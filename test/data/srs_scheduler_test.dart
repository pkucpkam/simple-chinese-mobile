import 'package:flutter_test/flutter_test.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:simple_chinese/data/models/srs_card.dart';
import 'package:simple_chinese/data/srs/exercise_selector.dart';
import 'package:simple_chinese/data/srs/srs_scheduler.dart';

void main() {
  // Tắt fuzz để khoảng ôn xác định.
  final scheduler = SrsScheduler(
    scheduler: fsrs.Scheduler(
      enableFuzzing: false,
      learningSteps: const [Duration(minutes: 1), Duration(minutes: 10)],
      relearningSteps: const [Duration(minutes: 10)],
    ),
  );
  final t0 = DateTime.utc(2026, 1, 1, 8);

  SrsCard fresh([CardSkill skill = CardSkill.read]) =>
      SrsCard(id: 1, wordId: 'w', skill: skill, due: t0);

  group('SrsScheduler.review', () {
    test('thẻ mới + Good → learning bước tiếp, đã có stability', () {
      final c = scheduler.review(fresh(), Rating.good, t0);
      expect(c.state, CardState.learning);
      expect(c.step, 1);
      expect(c.stability, greaterThan(0));
      expect(c.difficulty, greaterThan(0));
      expect(c.reps, 1);
      expect(c.lapses, 0);
      expect(c.due.difference(t0), const Duration(minutes: 10));
      expect(c.lastReview, t0);
    });

    test('thẻ mới + Again → ôn lại sau 1 phút', () {
      final c = scheduler.review(fresh(), Rating.again, t0);
      expect(c.state, CardState.learning);
      expect(c.due.difference(t0), const Duration(minutes: 1));
      expect(c.lapses, 0, reason: 'chưa thuộc thì không tính là quên');
    });

    test('thẻ mới + Easy → vào review ngay, khoảng ≥ 1 ngày', () {
      final c = scheduler.review(fresh(), Rating.easy, t0);
      expect(c.state, CardState.review);
      expect(c.due.difference(t0).inDays, greaterThanOrEqualTo(1));
    });

    test('học qua các bước rồi vào review; khoảng ôn tăng dần', () {
      var c = scheduler.review(fresh(), Rating.good, t0); // step 1
      var now = c.due;
      c = scheduler.review(c, Rating.good, now); // → review
      expect(c.state, CardState.review);
      final first = c.due.difference(now);

      now = c.due;
      c = scheduler.review(c, Rating.good, now);
      final second = c.due.difference(now);
      expect(second, greaterThan(first));
      expect(c.reps, 3);
    });

    test('quên thẻ đang review → relearning, lapses + 1, stability giảm', () {
      var c = scheduler.review(fresh(), Rating.easy, t0);
      final before = c.stability;
      final now = c.due;
      c = scheduler.review(c, Rating.again, now);
      expect(c.state, CardState.relearning);
      expect(c.lapses, 1);
      expect(c.stability, lessThan(before));
      expect(c.due.difference(now), const Duration(minutes: 10));
    });

    test('nhận thời gian local và vẫn ra kết quả UTC', () {
      final c = scheduler.review(fresh(), Rating.good, t0.toLocal());
      expect(c.due.isUtc, isTrue);
    });

    test('previewIntervals: Again < Hard ≤ Good < Easy', () {
      final p = scheduler.previewIntervals(fresh(), t0);
      expect(p[Rating.again], lessThan(p[Rating.hard]!));
      expect(p[Rating.hard], lessThanOrEqualTo(p[Rating.good]!));
      expect(p[Rating.good], lessThan(p[Rating.easy]!));
    });
  });

  group('ratingForAnswer (quy tắc chấm bài tập)', () {
    test('sai → Again', () {
      expect(
        SrsScheduler.ratingForAnswer(correct: false, elapsed: Duration.zero),
        Rating.again,
      );
    });
    test('đúng nhanh → Good', () {
      expect(
        SrsScheduler.ratingForAnswer(correct: true, elapsed: const Duration(seconds: 3)),
        Rating.good,
      );
    });
    test('đúng đúng 8 giây vẫn Good, quá 8 giây → Hard', () {
      expect(
        SrsScheduler.ratingForAnswer(correct: true, elapsed: const Duration(seconds: 8)),
        Rating.good,
      );
      expect(
        SrsScheduler.ratingForAnswer(
            correct: true, elapsed: const Duration(seconds: 8, milliseconds: 1)),
        Rating.hard,
      );
    });
  });

  group('ExerciseSelector', () {
    const selector = ExerciseSelector();
    SrsCard card({
      CardSkill skill = CardSkill.read,
      CardState state = CardState.review,
      double stability = 5,
    }) =>
        SrsCard(id: 1, wordId: 'w', skill: skill, due: t0, state: state, stability: stability);

    test('thẻ đọc mới → flashcard; thẻ nghe/thanh mới → vào thẳng bài tập', () {
      expect(selector.select(fresh()), ExerciseType.flashcard);
      expect(selector.select(fresh(CardSkill.listen)), ExerciseType.listenChoice);
      expect(selector.select(fresh(CardSkill.tone)), ExerciseType.toneChoice);
    });
    test('thẻ yếu → trắc nghiệm nghĩa', () {
      expect(selector.select(card(stability: 1)), ExerciseType.meaningChoice);
      expect(selector.select(card(state: CardState.relearning, stability: 50)),
          ExerciseType.meaningChoice);
      expect(selector.select(card(state: CardState.learning)), ExerciseType.meaningChoice);
    });
    test('thẻ trung bình → ghép cặp', () {
      expect(selector.select(card(stability: 5)), ExerciseType.matching);
    });
    test('thẻ mạnh → gõ pinyin', () {
      expect(selector.select(card(stability: 20)), ExerciseType.typePinyin);
    });
    test('thẻ nghe → nghe chọn chữ', () {
      expect(selector.select(card(skill: CardSkill.listen, stability: 20)),
          ExerciseType.listenChoice);
    });
    test('thẻ thanh điệu → chọn thanh', () {
      expect(selector.select(card(skill: CardSkill.tone)), ExerciseType.toneChoice);
    });
    test('dạng chưa có UI thì lùi về dạng có sẵn', () {
      const limited = ExerciseSelector(available: {
        ExerciseType.flashcard,
        ExerciseType.meaningChoice,
      });
      expect(limited.select(card(stability: 20)), ExerciseType.meaningChoice);
      expect(limited.select(card(skill: CardSkill.write, stability: 20)),
          ExerciseType.meaningChoice, reason: 'write chưa có → lùi về trắc nghiệm');
    });
    test('thẻ viết → viết chữ', () {
      expect(selector.select(card(skill: CardSkill.write, stability: 20)),
          ExerciseType.write);
      expect(selector.select(fresh(CardSkill.write)), ExerciseType.write);
    });
  });
}
