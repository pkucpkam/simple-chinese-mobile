import 'package:flutter/material.dart';

import '../../app/theme/tone_colors.dart';
import '../pinyin/pinyin.dart';

/// Hiển thị pinyin, mỗi âm tiết tô theo màu thanh điệu.
///
/// Đầu vào là pinyin có dấu tách âm tiết bằng dấu cách ("lǎo shī").
/// Dấu câu dính kèm âm tiết ("hǎo!") vẫn giữ nguyên, chỉ phần chữ mang màu.
class PinyinText extends StatelessWidget {
  const PinyinText(
    this.pinyin, {
    super.key,
    this.style,
    this.textAlign,
    this.colored = true,
  });

  final String pinyin;
  final TextStyle? style;
  final TextAlign? textAlign;

  /// Tắt để hiển thị một màu (vd khi nằm trên nền màu).
  final bool colored;

  @override
  Widget build(BuildContext context) {
    final base = DefaultTextStyle.of(context).style.merge(style);
    final tones = context.toneColors;

    // Giữ nguyên khoảng trắng gốc bằng cách tách theo (\s+) có giữ phần tách.
    final spans = <TextSpan>[];
    for (final match in RegExp(r'\S+|\s+').allMatches(pinyin)) {
      final token = match.group(0)!;
      if (token.trim().isEmpty || !colored) {
        spans.add(TextSpan(text: token));
        continue;
      }
      spans.add(TextSpan(
        text: token,
        style: TextStyle(color: tones.of(toneOfSyllable(token))),
      ));
    }
    return Text.rich(
      TextSpan(style: base, children: spans),
      textAlign: textAlign,
    );
  }
}
