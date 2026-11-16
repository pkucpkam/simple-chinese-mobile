import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/async_value_view.dart';
import '../../data/models/srs_card.dart';
import 'review_providers.dart';
import 'session/session_builder.dart';

/// Tab "Ôn tập": số thẻ cần ôn / thẻ mới hôm nay + nút bắt đầu phiên.
class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(deckStatsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(S.reviewTitle)),
      body: AsyncValueView(
        value: stats,
        data: (s) => s.total == 0 ? const _EmptyDeck() : _Body(stats: s),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.stats});

  final DeckStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasWork = stats.due + stats.newAvailable > 0;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Row(children: [
          Expanded(
            child: _StatCard(
              label: S.dueNow,
              value: '${stats.due}',
              color: theme.colorScheme.primary,
              icon: Icons.replay_rounded,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              label: S.newToday,
              value: S.newOfLimit(stats.newAvailable, stats.dailyNewLimit),
              color: AppColors.secondary,
              icon: Icons.fiber_new_rounded,
            ),
          ),
        ]),
        const SizedBox(height: 12),
        Text(
          '${S.reviewsToday}: ${stats.reviewsToday} · ${S.totalCards(stats.total)}',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 24),
        _ModeButton(
          icon: Icons.style_rounded,
          title: S.startFlashcards,
          subtitle: S.startFlashcardsHint,
          enabled: hasWork,
          onTap: () => context.push(Routes.session(SessionMode.flashcard.name)),
        ),
        const SizedBox(height: 12),
        _ModeButton(
          icon: Icons.quiz_rounded,
          title: S.startMixed,
          subtitle: S.startMixedHint,
          enabled: hasWork,
          onTap: () => context.push(Routes.session(SessionMode.mixed.name)),
        ),
        if (!hasWork) ...[
          const SizedBox(height: 24),
          Center(child: Text(S.allDoneBody, textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium)),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 12),
            Text(value, style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w800, color: color)),
            Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          enabled: enabled,
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: CircleAvatar(
            backgroundColor: scheme.primary.withValues(alpha: 0.12),
            child: Icon(icon, color: scheme.primary),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_rounded),
        ),
      ),
    );
  }
}

class _EmptyDeck extends StatelessWidget {
  const _EmptyDeck();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.style_outlined, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(S.deckEmptyTitle, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(S.deckEmptyBody, textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}
