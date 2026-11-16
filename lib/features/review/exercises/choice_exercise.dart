import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import '../../../core/audio/play_audio.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/models/word.dart';
import '../../../data/srs/exercise_selector.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../session/session_task.dart';
import 'answer_feedback.dart';
import 'exercise_callbacks.dart';

/// Trắc nghiệm 4 lựa chọn:
/// - meaningChoice: nhìn chữ Hán → chọn nghĩa.
/// - listenChoice: nghe → chọn chữ Hán.
class ChoiceExercise extends ConsumerStatefulWidget {
  const ChoiceExercise({
    super.key,
    required this.task,
    required this.onGrade,
    required this.onContinue,
  });

  final ChoiceTask task;
  final GradeCallback onGrade;
  final VoidCallback onContinue;

  @override
  ConsumerState<ChoiceExercise> createState() => _ChoiceExerciseState();
}

class _ChoiceExerciseState extends ConsumerState<ChoiceExercise> {
  final _watch = Stopwatch()..start();
  Word? _picked;
  Rating? _rating;

  /// Hiện pinyin làm gợi ý khi máy không phát được âm (bài nghe).
  bool _showPinyinHint = false;

  bool get _listen => widget.task.type == ExerciseType.listenChoice;
  Word get _answer => widget.task.item.word;

  @override
  void initState() {
    super.initState();
    if (_listen) WidgetsBinding.instance.addPostFrameCallback((_) => _play());
  }

  Future<void> _play() async {
    final ok = await playAudio(ref, context,
        text: _answer.hanzi, assetPath: _answer.audioPath);
    // Không phát được âm thì hiện pinyin để bài nghe vẫn làm được.
    if (!ok && mounted) setState(() => _showPinyinHint = true);
  }

  void _pick(Word w) {
    if (_picked != null) return;
    _watch.stop();
    final correct = w.id == _answer.id;
    final rating = SrsScheduler.ratingForAnswer(
      correct: correct,
      elapsed: _watch.elapsed,
    );
    correct ? Haptics.correct() : Haptics.wrong();
    setState(() {
      _picked = w;
      _rating = rating;
    });
    widget.onGrade(widget.task.item, rating, _watch.elapsed);
    // Bài nhìn chữ: phát âm sau khi trả lời để củng cố.
    if (!_listen) _play();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Text(
                _listen ? S.listenChooseHanzi : S.chooseMeaning,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              Center(child: _prompt(theme)),
              const SizedBox(height: 32),
              for (final (i, w) in widget.task.options.indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _OptionTile(
                    word: w,
                    showHanzi: _listen,
                    status: _statusOf(w),
                    onTap: () => _pick(w),
                  ).animate().fadeIn(delay: (60 * i).ms).slideX(begin: 0.05),
                ),
            ],
          ),
        ),
        if (_rating != null)
          AnswerFeedback(
            rating: _rating!,
            word: _answer,
            onContinue: widget.onContinue,
          ),
      ],
    );
  }

  Widget _prompt(ThemeData theme) {
    if (_listen) {
      return Column(children: [
        IconButton.filledTonal(
          iconSize: 48,
          padding: const EdgeInsets.all(22),
          onPressed: _play,
          icon: const Icon(Icons.volume_up_rounded),
        ),
        if (_showPinyinHint || _picked != null) ...[
          const SizedBox(height: 12),
          PinyinText(_answer.pinyin, style: theme.textTheme.titleLarge),
        ],
      ]);
    }
    return Column(children: [
      HanziText(_answer.hanzi, size: 72),
      // Pinyin chỉ hiện sau khi trả lời, để bài tập kiểm tra nhận diện chữ.
      AnimatedOpacity(
        opacity: _picked == null ? 0 : 1,
        duration: const Duration(milliseconds: 200),
        child: PinyinText(_answer.pinyin, style: theme.textTheme.titleLarge),
      ),
    ]);
  }

  _OptionStatus _statusOf(Word w) {
    if (_picked == null) return _OptionStatus.idle;
    if (w.id == _answer.id) return _OptionStatus.correct;
    if (w.id == _picked!.id) return _OptionStatus.wrong;
    return _OptionStatus.dimmed;
  }
}

enum _OptionStatus { idle, correct, wrong, dimmed }

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.word,
    required this.showHanzi,
    required this.status,
    required this.onTap,
  });

  final Word word;
  final bool showHanzi;
  final _OptionStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (status) {
      _OptionStatus.correct => kCorrectColor,
      _OptionStatus.wrong => theme.colorScheme.error,
      _ => theme.colorScheme.outlineVariant,
    };
    return AnimatedOpacity(
      opacity: status == _OptionStatus.dimmed ? 0.45 : 1,
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: status == _OptionStatus.correct || status == _OptionStatus.wrong
            ? color.withValues(alpha: 0.12)
            : theme.cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: color, width: status == _OptionStatus.idle ? 1 : 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: status == _OptionStatus.idle ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: showHanzi
                ? HanziText(word.hanzi, size: 30, serif: false, textAlign: TextAlign.center)
                : Text(word.meaningVi, style: theme.textTheme.titleMedium),
          ),
        ),
      ),
    );
  }
}
