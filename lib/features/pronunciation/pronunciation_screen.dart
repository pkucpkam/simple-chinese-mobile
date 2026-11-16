import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../core/widgets/async_value_view.dart';
import 'drill/drill_builder.dart';
import 'pronunciation_providers.dart';

/// Màn chính "Luyện phát âm": lối vào các bài luyện.
class PronunciationScreen extends ConsumerWidget {
  const PronunciationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drills = ref.watch(pronunciationDrillsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(S.pronunciationTitle)),
      body: AsyncValueView(
        value: drills,
        data: (d) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _Entry(
              icon: Icons.grid_on_rounded,
              title: S.pinyinChart,
              subtitle: S.pinyinChartHint,
              onTap: () => context.push(Routes.pinyinChart),
            ),
            _Entry(
              icon: Icons.hearing_rounded,
              title: S.toneDrill,
              subtitle: S.toneDrillHint,
              onTap: () => context.push(Routes.drill(const ToneDrill().code)),
            ),
            _Entry(
              icon: Icons.multiline_chart_rounded,
              title: S.tonePairDrill,
              subtitle: S.tonePairDrillHint,
              onTap: () => context.push(Routes.drill(const TonePairDrill().code)),
            ),
            _Entry(
              icon: Icons.mic_rounded,
              title: S.recordCompare,
              subtitle: S.recordCompareHint,
              onTap: () => context.push(Routes.record(hanzi: '你好', pinyin: 'nǐ hǎo')),
            ),
            const SizedBox(height: 16),
            Text(S.confusables, style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final g in d.confusables)
                  ActionChip(
                    label: Text(g.title),
                    onPressed: () =>
                        context.push(Routes.drill(ConfusableDrill(g.id).code)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: scheme.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: scheme.primary),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      ),
    );
  }
}
