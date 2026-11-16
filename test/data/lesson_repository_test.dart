import 'dart:convert';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/data/db/app_database.dart';
import 'package:simple_chinese/data/models/lesson.dart';
import 'package:simple_chinese/data/repositories/lesson_repository.dart';
import 'package:simple_chinese/data/repositories/settings_repository.dart';
import 'package:simple_chinese/data/repositories/srs_repository.dart';
import 'package:simple_chinese/data/repositories/stats_repository.dart';

void main() {
  late AppDatabase db;
  late LessonRepository repo;
  final now = DateTime(2026, 5, 1, 10);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final stats = StatsRepository(db, clock: () => now);
    final srs = SrsRepository(db, SettingsRepository(db), stats: stats, clock: () => now);
    repo = LessonRepository(db, srs: srs, stats: stats, clock: () => now);

    await db.batch((b) {
      for (var l = 1; l <= 3; l++) {
        b.insert(
          db.lessons,
          LessonsCompanion.insert(
            id: 'l$l',
            level: 1,
            order: l,
            title: 'Bài $l',
            contentJson: jsonEncode({
              'subtitle': 'phụ đề',
              'dialogue': [
                {'speaker': 'A', 'hanzi': '你好', 'pinyin': 'nǐ hǎo', 'vi': 'chào'},
              ],
              'sentences': [
                {'tokens': ['我', '是', '学生'], 'vi': 'Tôi là học sinh.'},
              ],
            }),
          ),
        );
        for (var w = 0; w < 2; w++) {
          b.insert(
            db.words,
            WordsCompanion.insert(
              id: 'w$l$w',
              hanzi: '字$l$w',
              pinyin: 'zì',
              pinyinPlain: 'zi',
              hanViet: 'tự',
              meaningVi: 'nghĩa',
              level: 1,
              lessonId: 'l$l',
              mustWrite: Value(w == 0),
            ),
          );
        }
      }
    });
  });
  tearDown(() => db.close());

  test('chỉ bài 1 mở lúc đầu', () async {
    final path = await repo.watchPath(1).first;
    expect(path.map((n) => n.unlocked), [true, false, false]);
    expect(path.first.wordCount, 2);
  });

  test('qua bài (≥ 80%) → mở bài sau, thêm thẻ (có thẻ viết), cộng XP', () async {
    final r = await repo.complete('l1', 90);
    expect(r.passed, isTrue);
    expect(r.unlockedNext, isTrue);
    expect(r.xp, LessonRepository.xpFirstPass);

    final path = await repo.watchPath(1).first;
    expect(path.map((n) => n.unlocked), [true, true, false]);
    expect(path.first.stars, 2);
    expect(path.first.completedAt, now);

    final cards = await db.select(db.cards).get();
    // 2 từ × (đọc, nghe, thanh) + 1 thẻ viết cho từ mustWrite.
    expect(cards, hasLength(7));
    expect(cards.where((c) => c.skill == CardSkill.write).single.wordId, 'w10');

    expect((await db.select(db.dailyStats).getSingle()).xp, LessonRepository.xpFirstPass);
  });

  test('trượt (< 80%) → không mở khoá, không thêm thẻ', () async {
    final r = await repo.complete('l1', 70);
    expect(r.passed, isFalse);
    expect(r.xp, 0);
    final path = await repo.watchPath(1).first;
    expect(path.map((n) => n.unlocked), [true, false, false]);
    expect(path.first.completedAt, isNull);
    expect(await db.select(db.cards).get(), isEmpty);
  });

  test('giữ điểm cao nhất; học lại không nhân đôi thẻ, XP lần sau thấp hơn', () async {
    await repo.complete('l1', 100);
    final again = await repo.complete('l1', 85);
    expect(again.newBest, isFalse);
    expect(again.unlockedNext, isFalse);
    expect(again.xp, LessonRepository.xpPass);

    final p = await (db.select(db.lessonProgress)..where((t) => t.lessonId.equals('l1')))
        .getSingle();
    expect(p.bestScore, 100);
    expect(await db.select(db.cards).get(), hasLength(7));
  });

  test('trượt rồi mới qua: lần qua đầu tiên vẫn mở khoá', () async {
    await repo.complete('l1', 50);
    final r = await repo.complete('l1', 80);
    expect(r.unlockedNext, isTrue);
    expect(r.xp, LessonRepository.xpFirstPass);
  });

  test('detail đọc hội thoại và câu sắp xếp', () async {
    final d = await repo.detail('l1');
    expect(d.words, hasLength(2));
    expect(d.dialogue.single.hanzi, '你好');
    expect(d.sentences.single.hanzi, '我是学生');
  });

  test('sao theo điểm', () {
    LessonNode n(int s) => LessonNode(
          lesson: const LessonSummary(id: 'x', level: 1, order: 1, title: 't'),
          wordCount: 0,
          bestScore: s,
          unlocked: true,
        );
    expect([n(0), n(79), n(80), n(90), n(100)].map((x) => x.stars), [0, 0, 1, 2, 3]);
  });
}
