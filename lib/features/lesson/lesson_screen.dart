import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/strings.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/async_value_view.dart';
import '../../data/models/lesson.dart';
import '../../data/models/srs_card.dart';
import '../../data/providers.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../data/srs/srs_scheduler.dart';
import '../path/path_providers.dart';
import '../review/exercises/choice_exercise.dart';
import '../review/exercises/tone_choice_exercise.dart';
import '../review/exercises/type_pinyin_exercise.dart';
import '../review/exercises/write_exercise.dart';
import '../review/session/session_task.dart';
import 'lesson_plan.dart';
import 'widgets/lesson_content_views.dart';
import 'widgets/sentence_order_exercise.dart';

enum _Stage { vocab, grammar, dialogue, practice, quiz, result }

/// Một bài học 5 bước: Từ mới → Ngữ pháp → Hội thoại → Luyện tập → Kiểm tra.
class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  final _planner = LessonPlanner();
  _Stage _stage = _Stage.vocab;
  List<LessonStep>? _practice;
  List<LessonStep>? _quiz;
  LessonResult? _result;
  int _quizAttempt = 0;

  static const _labels = [
    S.stepVocab, S.stepGrammar, S.stepDialogue, S.stepPractice, S.stepQuiz,
  ];

  void _go(_Stage s) => setState(() => _stage = s);

  Future<void> _finishQuiz(int correct, int total) async {
    final score = quizScore(correct, total);
    final result = await ref.read(lessonRepositoryProvider).complete(widget.lessonId, score);
    if (!mounted) return;
    setState(() {
      _result = result;
      _stage = _Stage.result;
    });
  }

  Future<bool> _confirmQuit() async =>
      await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(S.quitLessonTitle),
          content: const Text(S.quitLessonBody),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text(S.stay)),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text(S.quit)),
          ],
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(lessonDetailProvider(widget.lessonId));
    final pool = ref.watch(levelWordsProvider(1));
    final title = detail.value?.lesson.title ?? '';

    return PopScope(
      canPop: _stage == _Stage.result,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (await _confirmQuit() && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          title: Text(title),
          bottom: _stage == _Stage.result
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(44),
                  child: _StepBar(current: _stage.index, labels: _labels),
                ),
        ),
        body: AsyncValueView(
          value: detail,
          data: (d) {
            final words = pool.value;
            if (words == null) return const Center(child: CircularProgressIndicator());
            _practice ??= _planner.practice(d, pool: words);
            _quiz ??= _planner.quiz(d, pool: words);
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey('$_stage-$_quizAttempt'),
                child: switch (_stage) {
                  _Stage.vocab => VocabStep(words: d.words, onDone: () => _go(_Stage.grammar)),
                  _Stage.grammar =>
                    GrammarStep(points: d.grammar, onDone: () => _go(_Stage.dialogue)),
                  _Stage.dialogue =>
                    DialogueStep(lines: d.dialogue, onDone: () => _go(_Stage.practice)),
                  _Stage.practice => _StepRunner(
                      steps: _practice!,
                      onFinished: (_, _) => _go(_Stage.quiz),
                      finishLabel: S.startQuiz,
                    ),
                  _Stage.quiz => _StepRunner(
                      steps: _quiz!,
                      showScore: true,
                      onFinished: _finishQuiz,
                    ),
                  _Stage.result => _ResultView(
                      result: _result!,
                      onRetry: () => setState(() {
                        _quiz = _planner.quiz(d, pool: words);
                        _quizAttempt++;
                        _stage = _Stage.quiz;
                      }),
                    ),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Thanh 5 bước ở dưới AppBar.
class _StepBar extends StatelessWidget {
  const _StepBar({required this.current, required this.labels});

  final int current;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 6,
                  decoration: BoxDecoration(
                    color: i <= current ? scheme.primary : scheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 4),
                Text(labels[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: i == current ? FontWeight.w700 : FontWeight.w400,
                      color: i == current ? scheme.primary : scheme.onSurfaceVariant,
                    )),
              ]),
            ),
          ),
      ]),
    );
  }
}

/// Chạy lần lượt danh sách bài tập, đếm số câu đúng.
class _StepRunner extends StatefulWidget {
  const _StepRunner({
    required this.steps,
    required this.onFinished,
    this.showScore = false,
    this.finishLabel,
  });

  final List<LessonStep> steps;
  final void Function(int correct, int total) onFinished;
  final bool showScore;
  final String? finishLabel;

  @override
  State<_StepRunner> createState() => _StepRunnerState();
}

class _StepRunnerState extends State<_StepRunner> {
  int _index = 0;
  int _correct = 0;
  bool _answered = false;

  void _record(bool ok) {
    if (_answered) return; // mỗi câu chỉ tính lần trả lời đầu
    _answered = true;
    if (ok) _correct++;
  }

  void _grade(StudyItem _, Rating r, Duration _) => _record(r != Rating.again);

  void _next() {
    if (_index + 1 >= widget.steps.length) {
      widget.onFinished(_correct, widget.steps.length);
      return;
    }
    setState(() {
      _index++;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[_index];
    final theme = Theme.of(context);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Row(children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: _index / widget.steps.length,
                minHeight: 8,
                color: AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text('${_index + 1}/${widget.steps.length}', style: theme.textTheme.labelLarge),
        ]),
      ),
      Expanded(
        child: KeyedSubtree(
          key: ValueKey(_index),
          child: switch (step) {
            TaskStep(task: ChoiceTask() && final t) =>
              ChoiceExercise(task: t, onGrade: _grade, onContinue: _next),
            TaskStep(task: ToneChoiceTask() && final t) =>
              ToneChoiceExercise(task: t, onGrade: _grade, onContinue: _next),
            TaskStep(task: TypePinyinTask() && final t) =>
              TypePinyinExercise(task: t, onGrade: _grade, onContinue: _next),
            TaskStep() => const SizedBox(),
            SentenceStep(:final sentence) => SentenceOrderExercise(
                sentence: sentence, onAnswered: _record, onContinue: _next),
            WriteStep(:final item, :final guided) => WriteExercise(
                item: item, guided: guided, onGrade: _grade, onContinue: _next),
          },
        ),
      ),
    ]);
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({required this.result, required this.onRetry});

  final LessonResult result;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passed = result.passed;
    final color = passed ? const Color(0xFF1F9D55) : theme.colorScheme.error;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(children: [
        const Spacer(),
        Icon(passed ? Icons.emoji_events_rounded : Icons.sentiment_neutral_rounded,
                size: 88, color: passed ? AppColors.secondary : theme.colorScheme.outline)
            .animate()
            .scale(duration: 450.ms, curve: Curves.elasticOut),
        const SizedBox(height: 12),
        Text(passed ? S.lessonPassed : S.lessonFailed, style: theme.textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.w800, color: color)),
        const SizedBox(height: 8),
        Text(S.lessonScore(result.score), style: theme.textTheme.displaySmall
            ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        if (passed) ...[
          if (result.xp > 0)
            Text(S.xpGained(result.xp), style: theme.textTheme.titleMedium
                ?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text(S.wordsAddedToDeck, textAlign: TextAlign.center),
          if (result.unlockedNext) ...[
            const SizedBox(height: 4),
            Text(S.nextLessonUnlocked, style: theme.textTheme.titleSmall
                ?.copyWith(color: theme.colorScheme.primary)),
          ],
        ] else
          Text(S.needScore(kPassScore), textAlign: TextAlign.center),
        const Spacer(),
        if (!passed) ...[
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onRetry, child: const Text(S.retryQuiz)),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: double.infinity,
          child: passed
              ? FilledButton(onPressed: () => Navigator.pop(context), child: const Text(S.backToPath))
              : OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text(S.backToPath)),
        ),
      ]),
    );
  }
}
