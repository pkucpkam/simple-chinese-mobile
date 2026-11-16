import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/theme_mode_controller.dart';
import '../../app/theme/tone_colors.dart';
import '../../features/dictionary/word_providers.dart';

/// Tab "Tôi". Sprint 0: chọn giao diện sáng/tối + chú thích màu thanh điệu.
/// Sprint 4: streak, XP, heatmap, thống kê, nhắc học, backup.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeControllerProvider).value ?? ThemeMode.system;
    final wordCount = ref.watch(wordsByLevelProvider(1)).value?.length ?? 0;
    final tones = context.toneColors;

    return Scaffold(
      appBar: AppBar(title: const Text(S.meTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
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
