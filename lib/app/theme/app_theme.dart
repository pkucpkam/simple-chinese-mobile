import 'package:flutter/material.dart';

import 'tone_colors.dart';

/// Họ font đóng gói sẵn trong assets/fonts (xem pubspec.yaml).
abstract final class AppFonts {
  static const ui = 'BeVietnamPro';
  static const hanziSerif = 'NotoSerifSC';
  static const hanziSans = 'NotoSansSC';

  /// Fallback để chữ Hán lẫn trong câu tiếng Việt vẫn hiển thị bằng Noto.
  static const fallback = [hanziSans];
}

abstract final class AppColors {
  static const primary = Color(0xFFE5484D);
  static const secondary = Color(0xFFF5A524);
}

abstract final class AppRadius {
  static const card = 24.0;
  static const button = 16.0;
}

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      surface: isDark ? const Color(0xFF16171B) : const Color(0xFFFFFBFA),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      fontFamily: AppFonts.ui,
      fontFamilyFallback: AppFonts.fallback,
    );

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      extensions: [isDark ? ToneColors.dark : ToneColors.light],
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: isDark ? const Color(0xFF212228) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: scheme.primary.withValues(alpha: 0.14),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: const TextStyle(
            fontFamily: AppFonts.ui,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
