import 'package:freezed_annotation/freezed_annotation.dart';

import '../content/content_models.dart';
import 'word.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

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

/// Ngưỡng điểm quiz để qua bài và mở khoá bài sau.
const kPassScore = 80;

/// Một nút trên lộ trình: bài học + tiến độ của người học.
@freezed
abstract class LessonNode with _$LessonNode {
  const LessonNode._();

  const factory LessonNode({
    required LessonSummary lesson,
    required int wordCount,
    @Default(0) int bestScore,
    DateTime? completedAt,

    /// Bài đầu tiên luôn mở; bài sau mở khi bài trước đạt [kPassScore].
    required bool unlocked,
  }) = _LessonNode;

  bool get passed => bestScore >= kPassScore;

  /// 1–3 sao theo điểm cao nhất (0 nếu chưa qua bài).
  int get stars => bestScore >= 100
      ? 3
      : bestScore >= 90
          ? 2
          : passed
              ? 1
              : 0;
}

/// Một dòng hội thoại.
@freezed
abstract class DialogueLine with _$DialogueLine {
  const factory DialogueLine({
    required String speaker,
    required String hanzi,
    required String pinyin,
    required String vi,
  }) = _DialogueLine;

  factory DialogueLine.fromJson(Map<String, dynamic> json) =>
      _$DialogueLineFromJson(json);
}

/// Câu đã tách từ, dùng cho bài sắp xếp câu.
@freezed
abstract class OrderSentence with _$OrderSentence {
  const OrderSentence._();

  const factory OrderSentence({
    required List<String> tokens,
    required String vi,
  }) = _OrderSentence;

  factory OrderSentence.fromJson(Map<String, dynamic> json) =>
      _$OrderSentenceFromJson(json);

  String get hanzi => tokens.join();
}

/// Toàn bộ nội dung một bài để chạy 5 bước học.
@freezed
abstract class LessonDetail with _$LessonDetail {
  const factory LessonDetail({
    required LessonSummary lesson,
    required List<Word> words,
    required List<GrammarContent> grammar,
    required List<DialogueLine> dialogue,
    required List<OrderSentence> sentences,
  }) = _LessonDetail;
}
