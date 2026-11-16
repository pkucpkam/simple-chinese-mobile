import 'package:flutter/services.dart';

/// Phản hồi rung thống nhất khi trả lời.
abstract final class Haptics {
  static Future<void> correct() => HapticFeedback.lightImpact();
  static Future<void> wrong() => HapticFeedback.heavyImpact();
  static Future<void> tap() => HapticFeedback.selectionClick();
}
