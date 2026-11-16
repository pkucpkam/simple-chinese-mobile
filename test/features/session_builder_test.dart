import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/data/models/srs_card.dart';
import 'package:simple_chinese/data/models/word.dart';
import 'package:simple_chinese/data/srs/exercise_selector.dart';
import 'package:simple_chinese/features/review/session/session_builder.dart';
import 'package:simple_chinese/features/review/session/session_task.dart';

Word word(int i, {String? pinyin, String? meaning}) => Word(
      id: 'w$i',
      hanzi: '字$i',
      pinyin: pinyin ?? 'p$i',
      hanViet: 'hv',
      meaningVi: meaning ?? 'nghĩa $i',
      level: 1,
      lessonId: 'l1',
      mustWrite: false,
    );

StudyItem item(int i, {double stability = 5, CardState state = CardState.review,
    CardSkill skill = CardSkill.read, Word? w}) =>
    StudyItem(
      card: SrsCard(
        id: i,
        wordId: 'w$i',
        skill: skill,
        due: DateTime(2026),
        state: state,
        stability: stability,
      ),
      word: w ?? word(i),
    );

void main() {
  final pool = [for (var i = 0; i < 20; i++) word(i)];
  SessionBuilder builder() => SessionBuilder(random: Random(1));

  test('chế độ flashcard: mỗi thẻ một FlashcardTask', () {
    final tasks = builder().build([item(1), item(2)], mode: SessionMode.flashcard, pool: pool);
    expect(tasks, everyElement(isA<FlashcardTask>()));
  });

  test('gộp đủ 4 thẻ trung bình thành 1 ván ghép, phần dư → trắc nghiệm', () {
    final queue = [for (var i = 0; i < 6; i++) item(i)];
    final tasks = builder().build(queue, mode: SessionMode.mixed, pool: pool);
    expect(tasks.whereType<MatchingTask>().single.items, hasLength(4));
    expect(tasks.whereType<ChoiceTask>(), hasLength(2));
    // Mọi thẻ đều được chấm đúng một lần.
    expect(tasks.expand((t) => t.items).map((i) => i.card.id).toList()..sort(),
        [0, 1, 2, 3, 4, 5]);
  });

  test('dạng bài theo stability', () {
    final tasks = builder().build([
      item(1, state: CardState.fresh),
      item(2, stability: 1),
      item(3, stability: 30),
      item(4, skill: CardSkill.listen),
    ], mode: SessionMode.mixed, pool: pool);
    expect(tasks.map((t) => t.type).toList(), [
      ExerciseType.flashcard,
      ExerciseType.meaningChoice,
      ExerciseType.typePinyin,
      ExerciseType.listenChoice,
    ]);
  });

  test('đáp án trắc nghiệm: 4 lựa chọn, chứa đáp án đúng, không trùng nghĩa', () {
    final dupMeaning = [...pool, word(99, meaning: 'nghĩa 1')];
    for (var seed = 0; seed < 20; seed++) {
      final b = SessionBuilder(random: Random(seed));
      final opts = b.options(word(1), dupMeaning, ExerciseType.meaningChoice);
      expect(opts, hasLength(4));
      expect(opts.where((w) => w.id == 'w1'), hasLength(1));
      expect(opts.map((w) => w.meaningVi).toSet(), hasLength(4));
    }
  });

  test('nghe chọn chữ: loại từ đồng âm khỏi đáp án nhiễu (他/她)', () {
    final ta1 = word(1, pinyin: 'tā');
    final ta2 = word(2, pinyin: 'tā');
    final p = [ta1, ta2, for (var i = 3; i < 10; i++) word(i)];
    for (var seed = 0; seed < 20; seed++) {
      final opts = SessionBuilder(random: Random(seed))
          .options(ta1, p, ExerciseType.listenChoice);
      expect(opts.map((w) => w.id), isNot(contains('w2')));
    }
  });

  test('ván ghép không chứa 2 thẻ cùng nghĩa', () {
    final queue = [
      item(1, w: word(1, meaning: 'giống')),
      item(2, w: word(2, meaning: 'giống')),
      item(3), item(4), item(5),
    ];
    final tasks = builder().build(queue, mode: SessionMode.mixed, pool: pool);
    final match = tasks.whereType<MatchingTask>().single;
    expect(match.items.map((i) => i.word.meaningVi).toSet(), hasLength(4));
  });
}
