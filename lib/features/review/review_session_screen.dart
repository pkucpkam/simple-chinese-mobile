import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/async_value_view.dart';
import '../../data/models/srs_card.dart';
import '../../data/srs/srs_scheduler.dart';
import '../flashcard/flashcard_view.dart';
import 'exercises/choice_exercise.dart';
import 'exercises/matching_exercise.dart';
import 'exercises/tone_choice_exercise.dart';
import 'exercises/type_pinyin_exercise.dart';
import 'session/review_session_controller.dart';
import 'session/session_builder.dart';
import 'session/session_task.dart';

/// Màn chạy một phiên ôn (flashcard hoặc hỗn hợp).
class ReviewSessionScreen extends ConsumerWidget {
  const ReviewSessionScreen({super.key, required this.mode});

  final SessionMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = reviewSessionProvider(mode);
    final session = ref.watch(provider);
    final s = session.value;

    return PopScope(
      // Hỏi lại trước khi thoát giữa chừng.
      canPop: s == null || s.finished || s.isEmpty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmQuit(context) && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          titleSpacing: 0,
          title: s == null || s.isEmpty || s.finished
              ? null
              : TweenAnimationBuilder<double>(
                  tween: Tween(end: s.progress),
                  duration: const Duration(milliseconds: 300),
                  builder: (_, v, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(value: v, minHeight: 10),
                  ),
                ),
          actions: [
            if (s != null && !s.finished && !s.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: Text('${s.index + 1}/${s.tasks.length}')),
              ),
          ],
        ),
        body: AsyncValueView(
          value: session,
          onRetry: () => ref.invalidate(provider),
          data: (s) {
            if (s.isEmpty) return const _EmptySession();
            if (s.finished) return _Summary(state: s);
            final ctrl = ref.read(provider.notifier);
            void grade(StudyItem item, Rating r, Duration t) =>
                ctrl.grade(item, r, t).catchError((Object e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('$e')));
                  }
                });
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(s.index),
                child: _taskView(s.current!, grade, ctrl.next),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _taskView(
    SessionTask task,
    void Function(StudyItem, Rating, Duration) grade,
    VoidCallback next,
  ) {
    return switch (task) {
      FlashcardTask(:final item) => FlashcardView(
          item: item,
          // Flashcard: đánh giá xong là sang thẻ tiếp, không cần bấm Tiếp tục.
          onRated: (r, t) {
            grade(item, r, t);
            next();
          },
        ),
      ChoiceTask() => ChoiceExercise(task: task, onGrade: grade, onContinue: next),
      ToneChoiceTask() =>
        ToneChoiceExercise(task: task, onGrade: grade, onContinue: next),
      TypePinyinTask() =>
        TypePinyinExercise(task: task, onGrade: grade, onContinue: next),
      MatchingTask() =>
        MatchingExercise(task: task, onGrade: grade, onContinue: next),
    };
  }

  Future<bool> _confirmQuit(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(S.quitSessionTitle),
          content: const Text(S.quitSessionBody),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text(S.stay)),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text(S.quit)),
          ],
        ),
      ) ??
      false;
}

class _EmptySession extends StatelessWidget {
  const _EmptySession();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.celebration_rounded, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(S.allDoneTitle, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(S.allDoneBody, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text(S.done)),
        ]),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.state});

  final SessionState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stats = [
      (S.answered, '${state.answered}', Icons.style_rounded, theme.colorScheme.primary),
      (S.accuracy, '${(state.accuracy * 100).round()}%', Icons.track_changes_rounded,
          const Color(0xFF1F9D55)),
      (S.xpEarned, '+${state.xp}', Icons.bolt_rounded, AppColors.secondary),
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          const Icon(Icons.emoji_events_rounded, size: 80, color: AppColors.secondary)
              .animate()
              .scale(duration: 400.ms, curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text(S.sessionDone, style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 32),
          Row(
            children: [
              for (final (i, (label, value, icon, color)) in stats.indexed)
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      child: Column(children: [
                        Icon(icon, color: color),
                        const SizedBox(height: 8),
                        Text(value, style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800)),
                        Text(label, textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall),
                      ]),
                    ),
                  ).animate().fadeIn(delay: (120 * i).ms).slideY(begin: 0.2),
                ),
            ].expand((w) => [w, const SizedBox(width: 8)]).toList()..removeLast(),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(S.done),
            ),
          ),
        ],
      ),
    );
  }
}
