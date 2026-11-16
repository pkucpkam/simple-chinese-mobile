import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/theme_mode_controller.dart';
import '../../app/theme/tone_colors.dart';
import '../../core/utils/clock.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/async_value_view.dart';
import '../../data/providers.dart';
import '../../data/repositories/backup_repository.dart';
import '../../features/dictionary/word_providers.dart';
import '../review/review_providers.dart';
import 'profile_providers.dart';
import 'widgets/stats_widgets.dart';

/// Tab "Tôi": thống kê (streak, XP, heatmap, độ chính xác) + cài đặt.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeControllerProvider).value ?? ThemeMode.system;
    final wordCount = ref.watch(wordsByLevelProvider(1)).value?.length ?? 0;
    final stats = ref.watch(profileStatsProvider);
    final tones = context.toneColors;
    final today = AppClock.now();

    return Scaffold(
      appBar: AppBar(title: const Text(S.meTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          AsyncValueView(
            value: stats,
            data: (s) => Column(children: [
              StatsHeader(stats: s),
              const SizedBox(height: 16),
              _Section(
                title: S.activity,
                child: ActivityHeatmap(days: s.days, today: today),
              ),
              const SizedBox(height: 16),
              _Section(title: S.last7Days, child: WeeklyXpChart(days: s.days, today: today)),
              const SizedBox(height: 16),
              _Section(title: S.accuracyBySkill, child: SkillAccuracyBars(accuracy: s.accuracy)),
            ]),
          ),
          const SizedBox(height: 16),
          const _Section(title: S.studySettings, child: _DailyLimitSlider()),
          const SizedBox(height: 16),
          const _Section(title: S.reminder, child: _ReminderSetting()),
          const SizedBox(height: 16),
          _Section(
            title: S.appearance,
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.system, label: Text(S.themeSystem)),
                ButtonSegment(value: ThemeMode.light, label: Text(S.themeLight)),
                ButtonSegment(value: ThemeMode.dark, label: Text(S.themeDark)),
              ],
              selected: {mode},
              showSelectedIcon: false,
              onSelectionChanged: (s) =>
                  ref.read(themeModeControllerProvider.notifier).set(s.first),
            ),
          ),
          const SizedBox(height: 16),
          const _Section(title: S.backup, child: _BackupSetting()),
          const SizedBox(height: 16),
          _Section(
            title: S.toneLegend,
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                for (var t = 1; t <= 5; t++)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 6, backgroundColor: tones.of(t)),
                      const SizedBox(width: 6),
                      Text(S.toneNames[t - 1]),
                    ],
                  ),
              ],
            ),
          ),
          if (kDebugMode) ...[
            const SizedBox(height: 16),
            const _Section(title: S.devTools, child: _DevClock()),
          ],
          const SizedBox(height: 16),
          _Section(
            title: S.contentInfo,
            child: Text(S.wordsInDb(wordCount), style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _ReminderSetting extends ConsumerWidget {
  const _ReminderSetting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = ref.watch(reminderControllerProvider).value;
    if (r == null) return const SizedBox(height: 48);
    final ctrl = ref.read(reminderControllerProvider.notifier);
    return Column(children: [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text(S.reminder),
        value: r.enabled,
        onChanged: (v) async {
          final ok = await ctrl.setEnabled(v);
          if (!ok && context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(S.notificationDenied)));
          }
        },
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        enabled: r.enabled,
        leading: const Icon(Icons.schedule_rounded),
        title: Text(S.reminderAt(r.time.format(context))),
        trailing: const Icon(Icons.edit_rounded),
        onTap: () async {
          final t = await showTimePicker(context: context, initialTime: r.time);
          if (t != null) await ctrl.setTime(t);
        },
      ),
    ]);
  }
}

class _BackupSetting extends ConsumerWidget {
  const _BackupSetting();

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final json = await ref.read(backupRepositoryProvider).exportString();
    final name = 'simple-chinese-backup-${dayKey(AppClock.now())}.json';
    final uri = await FilePicker.saveFile(
      fileName: name,
      bytes: Uint8List.fromList(utf8.encode(json)),
    );
    if (uri != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.exported(name))));
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final files = await FilePicker.pickFiles();
    if (files.isEmpty || !context.mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(S.importConfirmTitle),
        content: const Text(S.importConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text(S.cancel)),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text(S.restore)),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final raw = utf8.decode(await files.first.readAsBytes());
      final n = await ref.read(backupRepositoryProvider).import(raw);
      // Cài đặt có thể đã đổi theo backup → đọc lại.
      ref
        ..invalidate(themeModeControllerProvider)
        ..invalidate(dailyNewLimitProvider)
        ..invalidate(reminderControllerProvider);
      messenger.showSnackBar(SnackBar(content: Text(S.imported(n))));
    } on BackupFormatException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.backupHint, style: theme.textTheme.bodySmall
          ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _export(context, ref),
            icon: const Icon(Icons.upload_file_rounded),
            label: const Text(S.exportBackup),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _import(context, ref),
            icon: const Icon(Icons.download_rounded),
            label: const Text(S.importBackup),
          ),
        ),
      ]),
    ]);
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _DailyLimitSlider extends ConsumerWidget {
  const _DailyLimitSlider();

  static const min = 0, max = 30;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(dailyNewLimitProvider).value;
    if (value == null) return const SizedBox(height: 48);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Expanded(child: Text(S.dailyNewLimit)),
          Text('$value', style: const TextStyle(fontWeight: FontWeight.w700)),
        ]),
        Slider(
          value: value.clamp(min, max).toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: (max - min) ~/ 5,
          label: '$value',
          onChanged: (v) =>
              ref.read(dailyNewLimitProvider.notifier).set(v.round()),
        ),
      ],
    );
  }
}

/// Tua thời gian để thử lịch ôn (chỉ hiện ở bản debug).
class _DevClock extends ConsumerStatefulWidget {
  const _DevClock();

  @override
  ConsumerState<_DevClock> createState() => _DevClockState();
}

class _DevClockState extends ConsumerState<_DevClock> {
  void _travel(Duration? by) {
    setState(() => by == null ? AppClock.reset() : AppClock.travel(by));
    // Thống kê bộ thẻ phụ thuộc thời gian → tính lại.
    ref.invalidate(deckStatsProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.clockOffset(formatInterval(AppClock.offset))),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          OutlinedButton(
              onPressed: () => _travel(const Duration(hours: 1)),
              child: const Text(S.plus1Hour)),
          OutlinedButton(
              onPressed: () => _travel(const Duration(days: 1)),
              child: const Text(S.plus1Day)),
          OutlinedButton(
              onPressed: () => _travel(const Duration(days: 10)),
              child: const Text(S.plus10Days)),
          TextButton(onPressed: () => _travel(null), child: const Text(S.resetClock)),
        ]),
      ],
    );
  }
}
