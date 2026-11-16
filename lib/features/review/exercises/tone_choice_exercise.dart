import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import '../../../core/audio/play_audio.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../session/session_task.dart';
import 'answer_feedback.dart';
import 'exercise_callbacks.dart';

/// Thẻ thanh điệu: nghe từ + nhìn chữ, chọn pinyin có thanh đúng.
class ToneChoiceExercise extends ConsumerStatefulWidget {
  const ToneChoiceExercise({
    super.key,
    required this.task,
    required this.onGrade,
    required this.onContinue,
  });

  final ToneChoiceTask task;
  final GradeCallback onGrade;
  final VoidCallback onContinue;

  @override
  ConsumerState<ToneChoiceExercise> createState() => _ToneChoiceExerciseState();
}

class _ToneChoiceExerciseState extends ConsumerState<ToneChoiceExercise> {
  final _watch = Stopwatch()..start();
  String? _picked;
  Rating? _rating;

  String get _answer => widget.task.item.word.pinyin;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _play());
  }

  void _play() {
    final w = widget.task.item.word;
    playAudio(ref, context, text: w.hanzi, assetPath: w.audioPath);
  }

  void _pick(String option) {
    if (_picked != null) return;
    _watch.stop();
    final correct = option == _answer;
    final rating = SrsScheduler.ratingForAnswer(correct: correct, elapsed: _watch.elapsed);
    correct ? Haptics.correct() : Haptics.wrong();
    setState(() {
      _picked = option;
      _rating = rating;
    });
    widget.onGrade(widget.task.item, rating, _watch.elapsed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final word = widget.task.item.word;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Text(S.chooseToneOf, style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Center(child: HanziText(word.hanzi, size: 72)),
              Center(
                child: IconButton(
                  onPressed: _play,
                  icon: const Icon(Icons.volume_up_rounded),
                  tooltip: S.replay,
                ),
              ),
              const SizedBox(height: 16),
              for (final (i, opt) in widget.task.options.indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _Option(
                    label: opt,
                    state: _picked == null
                        ? _S.idle
                        : opt == _answer
                            ? _S.correct
                            : opt == _picked
                                ? _S.wrong
                                : _S.dimmed,
                    onTap: () => _pick(opt),
                  ).animate().fadeIn(delay: (60 * i).ms),
                ),
            ],
          ),
        ),
        if (_rating != null)
          AnswerFeedback(rating: _rating!, word: word, onContinue: widget.onContinue),
      ],
    );
  }
}

enum _S { idle, correct, wrong, dimmed }

class _Option extends StatelessWidget {
  const _Option({required this.label, required this.state, required this.onTap});

  final String label;
  final _S state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (state) {
      _S.correct => kCorrectColor,
      _S.wrong => theme.colorScheme.error,
      _ => theme.colorScheme.outlineVariant,
    };
    return AnimatedOpacity(
      opacity: state == _S.dimmed ? 0.45 : 1,
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: state == _S.correct || state == _S.wrong
            ? color.withValues(alpha: 0.12)
            : theme.cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: color, width: state == _S.idle ? 1 : 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: state == _S.idle ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: PinyinText(label, style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
    );
  }
}
