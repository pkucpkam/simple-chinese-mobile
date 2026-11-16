import 'dart:math';

import 'package:flutter/material.dart';

import '../../../app/strings.dart';
import '../../../core/utils/haptics.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../data/models/lesson.dart';
import '../../../data/srs/srs_scheduler.dart';
import '../../review/exercises/answer_feedback.dart';

/// Sắp xếp các từ thành câu đúng. Chạm từ ở dưới để đưa lên dòng trả lời,
/// chạm từ trên dòng trả lời để bỏ ra.
class SentenceOrderExercise extends StatefulWidget {
  const SentenceOrderExercise({
    super.key,
    required this.sentence,
    required this.onAnswered,
    required this.onContinue,
    this.random,
  });

  final OrderSentence sentence;
  final ValueChanged<bool> onAnswered;
  final VoidCallback onContinue;
  final Random? random;

  @override
  State<SentenceOrderExercise> createState() => _SentenceOrderExerciseState();
}

class _SentenceOrderExerciseState extends State<SentenceOrderExercise> {
  /// Chỉ số (trong tokens gốc) của các từ còn ở "kho", đã xáo trộn.
  late final List<int> _bank = _shuffled();
  final List<int> _answer = [];
  bool? _correct;

  List<int> _shuffled() {
    final idx = List.generate(widget.sentence.tokens.length, (i) => i);
    final r = widget.random ?? Random();
    // Xáo tới khi khác thứ tự đúng (nếu câu có > 1 từ).
    do {
      idx.shuffle(r);
    } while (idx.length > 1 && _isIdentity(idx));
    return idx;
  }

  static bool _isIdentity(List<int> l) {
    for (var i = 0; i < l.length; i++) {
      if (l[i] != i) return false;
    }
    return true;
  }

  /// So sánh theo chữ (không theo chỉ số) để câu có từ lặp lại vẫn chấm đúng.
  bool get _isCorrect =>
      _answer.map((i) => widget.sentence.tokens[i]).join() == widget.sentence.hanzi;

  void _check() {
    final ok = _isCorrect;
    ok ? Haptics.correct() : Haptics.wrong();
    setState(() => _correct = ok);
    widget.onAnswered(ok);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = widget.sentence.tokens;
    final done = _correct != null;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Text(S.orderSentence, style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(widget.sentence.vi, style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 20),
              // Dòng trả lời
              Container(
                constraints: const BoxConstraints(minHeight: 72),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant, width: 2)),
                ),
                child: Wrap(spacing: 8, runSpacing: 8, children: [
                  for (final i in _answer)
                    _TokenChip(
                      text: tokens[i],
                      onTap: done
                          ? null
                          : () => setState(() {
                                _answer.remove(i);
                                _bank.add(i);
                              }),
                    ),
                ]),
              ),
              const SizedBox(height: 24),
              Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
                for (final i in _bank)
                  _TokenChip(
                    text: tokens[i],
                    onTap: done
                        ? null
                        : () {
                            Haptics.tap();
                            setState(() {
                              _bank.remove(i);
                              _answer.add(i);
                            });
                          },
                  ),
              ]),
              const SizedBox(height: 24),
              if (!done)
                FilledButton(
                  onPressed: _bank.isEmpty ? _check : null,
                  child: const Text(S.check),
                ),
              if (done && _correct == false) ...[
                const SizedBox(height: 8),
                Center(child: HanziText(widget.sentence.hanzi, size: 24, serif: false)),
              ],
            ],
          ),
        ),
        if (done)
          AnswerFeedback(
            rating: _correct! ? Rating.good : Rating.again,
            onContinue: widget.onContinue,
          ),
      ],
    );
  }
}

class _TokenChip extends StatelessWidget {
  const _TokenChip({required this.text, required this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: HanziText(text, size: 24, serif: false),
        ),
      ),
    );
  }
}
