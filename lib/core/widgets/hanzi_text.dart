import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

/// Chữ Hán hiển thị bằng Noto Serif SC (chữ lớn) hoặc Noto Sans SC.
class HanziText extends StatelessWidget {
  const HanziText(
    this.text, {
    super.key,
    this.size = 24,
    this.serif = true,
    this.weight,
    this.color,
    this.textAlign,
  });

  final String text;
  final double size;
  final bool serif;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? textAlign;

  static TextStyle style({
    double size = 24,
    bool serif = true,
    FontWeight? weight,
    Color? color,
  }) =>
      TextStyle(
        fontFamily: serif ? AppFonts.hanziSerif : AppFonts.hanziSans,
        fontFamilyFallback: const [AppFonts.hanziSans],
        fontSize: size,
        fontWeight: weight ?? (serif ? FontWeight.w600 : FontWeight.w400),
        color: color,
        height: 1.25,
      );

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: textAlign,
        style: style(size: size, serif: serif, weight: weight, color: color),
      );
}
