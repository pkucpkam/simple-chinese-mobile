import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';

/// Thông tin tóm tắt một bài học cho danh sách / lộ trình.
@freezed
abstract class LessonSummary with _$LessonSummary {
  const factory LessonSummary({
    required String id,
    required int level,
    required int order,
    required String title,
    @Default('') String subtitle,
  }) = _LessonSummary;
}
