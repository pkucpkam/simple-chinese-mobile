import 'package:fsrs/fsrs.dart' as fsrs;

import '../models/srs_card.dart';

/// Mức đánh giá một lượt ôn (trùng giá trị với FSRS: 1..4).
enum Rating {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const Rating(this.value);
  final int value;

  fsrs.Rating get _fsrs => fsrs.Rating.fromValue(value);
}

/// Bọc thuật toán FSRS (package `fsrs`) với domain model [SrsCard].
///
/// Mọi hàm đều thuần (không I/O), nhận thời điểm `now` từ ngoài vào để test
/// được chính xác.
class SrsScheduler {
  SrsScheduler({fsrs.Scheduler? scheduler})
      : _scheduler = scheduler ??
            fsrs.Scheduler(
              desiredRetention: 0.9,
              // Bước học ngắn: 1 phút → 10 phút, rồi mới sang lịch theo ngày.
              learningSteps: const [Duration(minutes: 1), Duration(minutes: 10)],
              relearningSteps: const [Duration(minutes: 10)],
              maximumInterval: 365 * 3,
            );

  final fsrs.Scheduler _scheduler;

  /// Ngưỡng "trả lời chậm": đúng nhưng lâu hơn mức này → Hard.
  static const slowAnswer = Duration(seconds: 8);

  /// Quy tắc chấm cho bài tập tự động:
  /// sai → Again, đúng nhưng chậm hơn [slowAnswer] → Hard, đúng nhanh → Good.
  static Rating ratingForAnswer({
    required bool correct,
    required Duration elapsed,
  }) {
    if (!correct) return Rating.again;
    return elapsed > slowAnswer ? Rating.hard : Rating.good;
  }

  /// Áp dụng một lượt ôn, trả về thẻ đã cập nhật lịch.
  SrsCard review(SrsCard card, Rating rating, DateTime now) {
    final nowUtc = now.toUtc();
    final result = _scheduler.reviewCard(
      _toFsrs(card, nowUtc),
      rating._fsrs,
      reviewDateTime: nowUtc,
    );
    final next = result.card;
    // "Lapse" = quên một thẻ đã thuộc (đang ở trạng thái review).
    final lapsed = rating == Rating.again && card.state == CardState.review;
    return card.copyWith(
      state: CardState.fromValue(next.state.value),
      step: next.step,
      stability: next.stability ?? 0,
      difficulty: next.difficulty ?? 0,
      due: next.due,
      lastReview: next.lastReview,
      reps: card.reps + 1,
      lapses: card.lapses + (lapsed ? 1 : 0),
    );
  }

  /// Khoảng thời gian tới lần ôn kế tiếp cho từng mức đánh giá
  /// (để hiện dưới 4 nút Again/Hard/Good/Easy).
  Map<Rating, Duration> previewIntervals(SrsCard card, DateTime now) => {
        for (final r in Rating.values)
          r: review(card, r, now).due.difference(now.toUtc()),
      };

  /// Thẻ "fresh" của app tương ứng thẻ learning bước 0 chưa có stability
  /// trong fsrs. fsrs yêu cầu mọi thời điểm ở UTC.
  fsrs.Card _toFsrs(SrsCard c, DateTime nowUtc) {
    if (c.isNew) {
      return fsrs.Card(cardId: c.id, state: fsrs.State.learning, step: 0, due: nowUtc);
    }
    return fsrs.Card(
      cardId: c.id,
      state: fsrs.State.fromValue(c.state.value),
      step: c.step,
      stability: c.stability,
      difficulty: c.difficulty,
      due: c.due.toUtc(),
      lastReview: c.lastReview?.toUtc(),
    );
  }
}
