import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/tone_colors.dart';
import '../../core/widgets/hanzi_text.dart';
import '../../data/repositories/settings_repository.dart';
import '../profile/profile_providers.dart';
import '../review/review_providers.dart';

/// Giới thiệu lần đầu mở app: chào mừng → mục tiêu mỗi ngày → giờ nhắc học.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _page = PageController();
  int _index = 0;
  int _goal = SettingsRepository.defaultDailyNewLimit;
  bool _remind = true;
  TimeOfDay _time = SettingsRepository.defaultReminder;
  bool _saving = false;

  static const _pages = 3;

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  void _next() => _page.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

  Future<void> _finish({required bool withReminder}) async {
    setState(() => _saving = true);
    await ref.read(dailyNewLimitProvider.notifier).set(_goal);
    final reminders = ref.read(reminderControllerProvider.notifier);
    await reminders.setTime(_time);
    if (withReminder) await reminders.setEnabled(true); // bị từ chối quyền thì thôi
    await ref.read(onboardingDoneProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView(
              controller: _page,
              onPageChanged: (i) => setState(() => _index = i),
              children: [_welcome(theme), _goalPage(theme), _reminderPage(theme)],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (var i = 0; i < _pages; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                width: i == _index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _index
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
            child: _index < _pages - 1
                ? SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: _next, child: const Text(S.next)),
                  )
                : Row(children: [
                    TextButton(
                      onPressed: _saving ? null : () => _finish(withReminder: false),
                      child: const Text(S.skip),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: _saving ? null : () => _finish(withReminder: _remind),
                        child: const Text(S.getStarted),
                      ),
                    ),
                  ]),
          ),
        ]),
      ),
    );
  }

  Widget _welcome(ThemeData theme) {
    final tones = context.toneColors;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        HanziText('汉语', size: 96, color: theme.colorScheme.primary)
            .animate()
            .fadeIn(duration: 500.ms)
            .scale(begin: const Offset(0.8, 0.8)),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: 'hàn ', style: TextStyle(color: tones.tone4)),
            TextSpan(text: 'yǔ', style: TextStyle(color: tones.tone3)),
          ]),
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 32),
        Text(S.welcomeTitle, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text(S.welcomeBody, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
      ]),
    );
  }

  Widget _goalPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.flag_rounded, size: 56, color: AppColors.secondary),
        const SizedBox(height: 16),
        Text(S.goalTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(S.goalBody, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 24),
        for (final e in S.goalOptions.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: _goal == e.key
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : theme.cardTheme.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: _goal == e.key ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                  width: _goal == e.key ? 2 : 1,
                ),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                onTap: () => setState(() => _goal = e.key),
                title: Text(e.value, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(S.cardsPerDay(e.key)),
                trailing: _goal == e.key
                    ? Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary)
                    : null,
              ),
            ),
          ),
      ]),
    );
  }

  Widget _reminderPage(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.notifications_active_rounded, size: 56, color: theme.colorScheme.primary),
        const SizedBox(height: 16),
        Text(S.reminderTitleOnboarding, style: theme.textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(S.reminderBodyOnboarding, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 24),
        Card(
          child: Column(children: [
            SwitchListTile(
              title: const Text(S.reminder),
              value: _remind,
              onChanged: (v) => setState(() => _remind = v),
            ),
            ListTile(
              enabled: _remind,
              leading: const Icon(Icons.schedule_rounded),
              title: Text(S.reminderAt(_time.format(context))),
              trailing: const Text(S.pickTime),
              onTap: () async {
                final t = await showTimePicker(context: context, initialTime: _time);
                if (t != null) setState(() => _time = t);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
