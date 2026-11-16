import 'package:flutter/foundation.dart';

/// Đồng hồ của app. Bản debug có thể "tua thời gian" để kiểm tra lịch ôn
/// SRS mà không phải đổi giờ hệ thống (emulator thường không cho đổi).
/// Bản release luôn dùng giờ thật.
abstract final class AppClock {
  static Duration _offset = Duration.zero;

  static DateTime now() => DateTime.now().add(_offset);

  static Duration get offset => _offset;

  /// Chỉ có tác dụng ở bản debug.
  static void travel(Duration by) {
    if (kDebugMode) _offset += by;
  }

  static void reset() => _offset = Duration.zero;
}
