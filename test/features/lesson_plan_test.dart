import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/data/models/lesson.dart';
import 'package:simple_chinese/data/models/word.dart';
import 'package:simple_chinese/data/repositories/stroke_repository.dart';
import 'package:simple_chinese/data/srs/srs_scheduler.dart';
import 'package:simple_chinese/features/lesson/lesson_plan.dart';
import 'package:simple_chinese/features/review/exercises/write_exercise.dart';
import 'package:simple_chinese/features/review/session/session_task.dart';

Word word(int i, {bool mustWrite = false}) => Word(
      id: 'w$i',
      hanzi: '字$i',
      pinyin: 'zì',
      hanViet: 'tự',
      meaningVi: 'nghĩa $i',
      level: 1,
      lessonId: 'l',
      mustWrite: mustWrite,
    );

LessonDetail detail(int nWords) => LessonDetail(
      lesson: const LessonSummary(id: 'l', level: 1, order: 1, title: 't'),
      words: [for (var i = 0; i < nWords; i++) word(i, mustWrite: i == 0)],
      grammar: const [],
      dialogue: const [],
      sentences: const [
        OrderSentence(tokens: ['我', '是', '学生'], vi: 'a'),
        OrderSentence(tokens: ['你', '好'], vi: 'b'),
      ],
    );

void main() {
  final pool = [for (var i = 0; i < 30; i++) word(i)];

  test('luyện tập: mỗi từ 1 câu + 1 sắp xếp + 1 tập tô', () {
    final steps = LessonPlanner(random: Random(1)).practice(detail(10), pool: pool);
    expect(steps.whereType<TaskStep>(), hasLength(10));
    expect(steps.whereType<SentenceStep>(), hasLength(1));
    final write = steps.whereType<WriteStep>().single;
    expect(write.guided, isTrue);
    expect(write.item.word.mustWrite, isTrue);
  });

  test('kiểm tra: đủ 10 câu, trộn dạng, kể cả bài ít từ', () {
    for (final n in [3, 7, 11]) {
      final steps = LessonPlanner(random: Random(n)).quiz(detail(n), pool: pool);
      expect(steps, hasLength(LessonPlanner.quizLength));
      final tasks = steps.whereType<TaskStep>().map((s) => s.task).toList();
      expect(tasks.whereType<ChoiceTask>(), hasLength(6));
      expect(tasks.whereType<ToneChoiceTask>(), hasLength(2));
      expect(tasks.whereType<TypePinyinTask>(), hasLength(1));
      expect(steps.whereType<SentenceStep>().single.sentence.vi, 'b');
    }
  });

  test('điểm quiz', () {
    expect(quizScore(8, 10), 80);
    expect(quizScore(2, 3), 67);
    expect(quizScore(0, 0), 0);
  });

  test('chấm viết chữ', () {
    expect(rateWriting(strokes: 7, mistakes: 0, hintUsed: false), Rating.good);
    expect(rateWriting(strokes: 7, mistakes: 2, hintUsed: false), Rating.hard);
    expect(rateWriting(strokes: 7, mistakes: 4, hintUsed: false), Rating.again);
    expect(rateWriting(strokes: 7, mistakes: 0, hintUsed: true), Rating.again);
  });

  test('mọi chữ trong từ vựng đều có dữ liệu nét', () {
    final words =
        (jsonDecode(File('assets/content/hsk1/words.json').readAsStringSync())
            as Map<String, dynamic>)['items'] as List;
    final missing = <String>{};
    for (final w in words) {
      for (final c in ((w as Map)['hanzi'] as String).runes.map(String.fromCharCode)) {
        if (!File(StrokeRepository.assetFor(c)).existsSync()) missing.add(c);
      }
    }
    expect(missing, isEmpty);
  });
}
