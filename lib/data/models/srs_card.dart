import 'package:freezed_annotation/freezed_annotation.dart';

import 'word.dart';

part 'srs_card.freezed.dart';

/// Kỹ năng của một thẻ. Mỗi từ có thể có nhiều thẻ (mỗi kỹ năng một thẻ).
enum CardSkill { read, listen, tone, write }

/// Trạng thái thẻ. Giá trị số trùng với cột `cards.state` trong DB.
/// `fresh` (0) = chưa học lần nào; 1..3 trùng với `State` của package fsrs.
enum CardState {
  fresh(0),
  learning(1),
  review(2),
  relearning(3);

  const CardState(this.value);
  final int value;

  static CardState fromValue(int v) =>
      values.firstWhere((s) => s.value == v, orElse: () => fresh);
}

/// Thẻ ôn tập (domain model, không phụ thuộc DB hay package fsrs).
@freezed
abstract class SrsCard with _$SrsCard {
  const SrsCard._();

  const factory SrsCard({
    required int id,
    required String wordId,
    required CardSkill skill,
    @Default(0) double stability,
    @Default(0) double difficulty,
    required DateTime due,
    @Default(CardState.fresh) CardState state,
    int? step,
    @Default(0) int reps,
    @Default(0) int lapses,
    DateTime? lastReview,
  }) = _SrsCard;

  bool get isNew => state == CardState.fresh;
}

/// Một thẻ kèm từ vựng của nó — đơn vị dùng trong phiên học.
@freezed
abstract class StudyItem with _$StudyItem {
  const factory StudyItem({required SrsCard card, required Word word}) =
      _StudyItem;
}

/// Thống kê nhanh cho màn Ôn tập.
@freezed
abstract class DeckStats with _$DeckStats {
  const factory DeckStats({
    /// Thẻ đã học và đã đến hạn.
    required int due,

    /// Thẻ mới còn được phép học hôm nay (đã trừ giới hạn ngày).
    required int newAvailable,

    /// Thẻ mới đã học hôm nay.
    required int newToday,
    required int dailyNewLimit,

    /// Tổng số thẻ trong bộ.
    required int total,
    required int reviewsToday,
  }) = _DeckStats;
}
