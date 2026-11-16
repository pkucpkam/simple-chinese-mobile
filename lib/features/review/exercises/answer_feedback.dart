import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/strings.dart';
import '../../../core/widgets/hanzi_text.dart';
import '../../../core/widgets/pinyin_text.dart';
import '../../../data/models/word.dart';
import '../../../data/srs/srs_scheduler.dart';

/// Màu "đúng" dùng chung cho các bài tập.
const kCorrectColor = Color(0xFF1F9D55);

/// Thanh phản hồi sau khi trả lời: đúng/sai, đáp án, nút Tiếp tục.
class AnswerFeedback extends StatelessWidget {
  const AnswerFeedback({
    super.key,
    required this.rating,
    required this.onContinue,
    this.word,
    this.title,
  });

  final Rating rating;
  final VoidCallback onContinue;

  /// Từ đúng để hiển thị lại (null với ghép cặp).
  final Word? word;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ok = rating != Rating.again;
    final color = ok ? kCorrectColor : theme.colorScheme.error;
    final heading = title ??
        switch (rating) {
          Rating.again => S.wrong,
          Rating.hard => S.slowButCorrect,
          _ => S.correct,
        };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Icon(ok ? Icons.check_circle_rounded : Icons.cancel_rounded, color: color),
              const SizedBox(width: 8),
              Text(heading, style: theme.textTheme.titleMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.w700)),
            ]),
            if (word != null) ...[
              const SizedBox(height: 8),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  HanziText(word!.hanzi, size: 24, serif: false),
                  PinyinText(word!.pinyin, style: theme.textTheme.titleMedium),
                ],
              ),
              Text(word!.meaningVi, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: color),
                onPressed: onContinue,
                child: const Text(S.continueLabel),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1, duration: 220.ms, curve: Curves.easeOut);
  }
}
