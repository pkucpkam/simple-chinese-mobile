import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/strings.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/models/srs_card.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../../writing/widgets/writing_pad.dart';
import 'answer_feedback.dart';
import 'exercise_callbacks.dart';

/// Chấm bài viết chữ:
/// - dùng gợi ý (chuyển sang tập tô) hoặc sai quá nửa số nét → Again;
/// - có sai nét → Hard; không sai → Good.
/// Không áp dụng quy tắc 8 giây vì viết chữ vốn mất thời gian.
Rating rateWriting({
  required int strokes,
  required int mistakes,
  required bool hintUsed,
}) {
  if (hintUsed || mistakes * 2 > strokes) return Rating.again;
  return mistakes > 0 ? Rating.hard : Rating.good;
}

/// Viết từ trí nhớ, lần lượt từng chữ của từ (chấm theo [rateWriting]).
class WriteExercise extends StatefulWidget {
  const WriteExercise({
    super.key,
    required this.item,
    required this.onGrade,
    required this.onContinue,
    this.guided = false,
  });

  final StudyItem item;

  /// Bắt đầu ở chế độ tập tô (phần Luyện tập của bài học) — không tính là
  /// dùng gợi ý.
  final bool guided;
  final GradeCallback onGrade;
  final VoidCallback onContinue;

  @override
  State<WriteExercise> createState() => _WriteExerciseState();
}

class _WriteExerciseState extends State<WriteExercise> {
  final _watch = Stopwatch()..start();
  late final List<String> _chars = widget.item.word.chars;
  int _index = 0;
  int _strokes = 0;
  int _mistakes = 0;
  bool _hintUsed = false;
  late bool _showHint = widget.guided;
  Rating? _rating;

  void _onChar(WritingResult r) {
    _strokes += r.strokes;
    _mistakes += r.mistakes;
    if (_index + 1 < _chars.length) {
      setState(() {
        _index++;
        _showHint = widget.guided;
      });
      return;
    }
    _watch.stop();
    final rating = rateWriting(
      strokes: _strokes,
      mistakes: _mistakes,
      hintUsed: _hintUsed,
    );
    setState(() => _rating = rating);
    widget.onGrade(widget.item, rating, _watch.elapsed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final word = widget.item.word;
    return Column(
      children: [
        // Column thay vì ListView để cử chỉ cuộn không "cướp" nét vẽ.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.writeFromMemory,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: PinyinText(
                    word.pinyin,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                Center(
                  child: Text(
                    word.meaningVi,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                if (_chars.length > 1)
                  Center(child: Text(S.charOf(_index + 1, _chars.length))),
                const SizedBox(height: 12),
                Expanded(
                  child: LayoutBuilder(
                    builder: (_, box) => Center(
                      child: WritingPad(
                        key: ValueKey('$_index-$_showHint'),
                        char: _chars[_index],
                        mode: _showHint
                            ? WritingMode.trace
                            : WritingMode.recall,
                        size: min(
                          box.maxWidth,
                          box.maxHeight,
                        ).clamp(140.0, 320.0),
                        onComplete: _rating == null ? _onChar : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: _rating != null || _showHint
                      ? null
                      : Center(
                          child: TextButton.icon(
                            onPressed: () => setState(() {
                              _hintUsed = true;
                              _showHint = true;
                            }),
                            icon: const Icon(Icons.lightbulb_outline_rounded),
                            label: const Text(S.hint),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        if (_rating != null)
          AnswerFeedback(
            rating: _rating!,
            word: word,
            onContinue: widget.onContinue,
          ),
      ],
    );
  }
}
