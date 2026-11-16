import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/strings.dart';
import '../../../core/audio/play_audio.dart';
import '../../../core/pinyin/pinyin.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../session/session_task.dart';
import 'answer_feedback.dart';
import 'exercise_callbacks.dart';

/// Gõ pinyin có số thanh ("ni3 hao3"). Bên dưới ô nhập hiện ngay bản có dấu
/// (tô màu thanh) để người học thấy mình đang gõ gì.
class TypePinyinExercise extends ConsumerStatefulWidget {
  const TypePinyinExercise({
    super.key,
    required this.task,
    required this.onGrade,
    required this.onContinue,
  });

  final TypePinyinTask task;
  final GradeCallback onGrade;
  final VoidCallback onContinue;

  @override
  ConsumerState<TypePinyinExercise> createState() => _TypePinyinExerciseState();
}

class _TypePinyinExerciseState extends ConsumerState<TypePinyinExercise> {
  final _watch = Stopwatch()..start();
  final _controller = TextEditingController();
  Rating? _rating;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_rating != null || _controller.text.trim().isEmpty) return;
    _watch.stop();
    final word = widget.task.item.word;
    final correct = numberedAnswerMatches(_controller.text, word.pinyin);
    final rating = SrsScheduler.ratingForAnswer(correct: correct, elapsed: _watch.elapsed);
    correct ? Haptics.correct() : Haptics.wrong();
    setState(() => _rating = rating);
    widget.onGrade(widget.task.item, rating, _watch.elapsed);
    playAudio(ref, context, text: word.hanzi, assetPath: word.audioPath);
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
              Text(S.typePinyinPrompt, style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Center(child: HanziText(word.hanzi, size: 72)),
              Center(
                child: Text(word.meaningVi, style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _controller,
                autofocus: true,
                enabled: _rating == null,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.visiblePassword, // tắt gợi ý từ
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                onChanged: (_) => setState(() {}),
                style: theme.textTheme.titleLarge,
                decoration: InputDecoration(
                  hintText: S.typePinyinHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                ),
              ),
              const SizedBox(height: 12),
              // Xem trước dạng có dấu của chuỗi đang gõ.
              Center(
                child: PinyinText(
                  numberedToMarked(_controller.text.toLowerCase()),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 24),
              if (_rating == null)
                FilledButton(onPressed: _submit, child: const Text(S.check)),
            ],
          ),
        ),
        if (_rating != null)
          AnswerFeedback(rating: _rating!, word: word, onContinue: widget.onContinue),
      ],
    );
  }
}
