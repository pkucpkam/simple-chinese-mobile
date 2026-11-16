import 'package:flutter/material.dart';

/// Màu thanh điệu dùng thống nhất toàn app.
/// Thanh 1 xanh dương, 2 xanh lá, 3 cam, 4 đỏ, 5 (nhẹ) xám.
@immutable
class ToneColors extends ThemeExtension<ToneColors> {
  const ToneColors({
    required this.tone1,
    required this.tone2,
    required this.tone3,
    required this.tone4,
    required this.neutral,
  });

  final Color tone1;
  final Color tone2;
  final Color tone3;
  final Color tone4;
  final Color neutral;

  static const light = ToneColors(
    tone1: Color(0xFF1E6FD9),
    tone2: Color(0xFF1F9D55),
    tone3: Color(0xFFE07B00),
    tone4: Color(0xFFD9363E),
    neutral: Color(0xFF8A8F98),
  );

  /// Bản sáng hơn để đủ tương phản trên nền tối.
  static const dark = ToneColors(
    tone1: Color(0xFF6AA8FF),
    tone2: Color(0xFF4CD08A),
    tone3: Color(0xFFFFA940),
    tone4: Color(0xFFFF6B70),
    neutral: Color(0xFFA0A6B0),
  );

  /// [tone] 1..4, giá trị khác coi là thanh nhẹ.
  Color of(int tone) => switch (tone) {
        1 => tone1,
        2 => tone2,
        3 => tone3,
        4 => tone4,
        _ => neutral,
      };

  @override
  ToneColors copyWith({
    Color? tone1,
    Color? tone2,
    Color? tone3,
    Color? tone4,
    Color? neutral,
  }) =>
      ToneColors(
        tone1: tone1 ?? this.tone1,
        tone2: tone2 ?? this.tone2,
        tone3: tone3 ?? this.tone3,
        tone4: tone4 ?? this.tone4,
        neutral: neutral ?? this.neutral,
      );

  @override
  ToneColors lerp(ToneColors? other, double t) {
    if (other == null) return this;
    return ToneColors(
      tone1: Color.lerp(tone1, other.tone1, t)!,
      tone2: Color.lerp(tone2, other.tone2, t)!,
      tone3: Color.lerp(tone3, other.tone3, t)!,
      tone4: Color.lerp(tone4, other.tone4, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
    );
  }
}

extension ToneColorsX on BuildContext {
  ToneColors get toneColors =>
      Theme.of(this).extension<ToneColors>() ?? ToneColors.light;
}
