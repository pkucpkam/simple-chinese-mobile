import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:simple_chinese/data/db/app_database.dart';
import 'package:simple_chinese/data/models/profile_stats.dart';
import 'package:simple_chinese/data/repositories/backup_repository.dart';
import 'package:simple_chinese/data/repositories/settings_repository.dart';
import 'package:simple_chinese/data/repositories/srs_repository.dart';
import 'package:simple_chinese/data/repositories/stats_repository.dart';
import 'package:simple_chinese/data/srs/srs_scheduler.dart';

void main() {
  group('computeStreak', () {
    final today = DateTime(2026, 3, 10);
    DateTime d(int day) => DateTime(2026, 3, day);

    test('chuỗi tính tới hôm nay', () {
      expect(computeStreak({d(8), d(9), d(10)}, today), (3, 3));
    });
    test('hôm nay chưa học: chuỗi tính tới hôm qua, chưa đứt', () {
      expect(computeStreak({d(8), d(9)}, today), (2, 2));
    });
    test('bỏ một ngày là đứt chuỗi; giữ kỷ lục cũ', () {
      expect(computeStreak({d(1), d(2), d(3), d(4), d(8)}, today), (0, 4));
    });
    test('qua ranh giới tháng', () {
      expect(computeStreak({DateTime(2026, 2, 28), DateTime(2026, 3, 1)}, DateTime(2026, 3, 1)),
          (2, 2));
    });
    test('không có ngày nào', () {
      expect(computeStreak({}, today), (0, 0));
    });
  });

  group('thống kê & backup', () {
    late AppDatabase db;
    late SrsRepository srs;
    late StatsRepository stats;
    late SettingsRepository settings;
    var now = DateTime(2026, 3, 10, 9);

    setUp(() async {
      now = DateTime(2026, 3, 10, 9);
      db = AppDatabase(NativeDatabase.memory());
      settings = SettingsRepository(db);
      stats = StatsRepository(db, clock: () => now);
      srs = SrsRepository(db, settings,
          stats: stats,
          clock: () => now,
          scheduler: SrsScheduler(scheduler: fsrs.Scheduler(enableFuzzing: false)));
      await db.into(db.words).insert(WordsCompanion.insert(
          id: 'w0', hanzi: '你', pinyin: 'nǐ', pinyinPlain: 'ni', hanViet: 'nhĩ',
          meaningVi: 'bạn', level: 1, lessonId: 'l1'));
      await srs.addWords(['w0']);
    });
    tearDown(() => db.close());

    test('profile: XP, streak, độ chính xác theo kỹ năng', () async {
      final cards = await db.select(db.cards).get();
      final read = cards.firstWhere((c) => c.skill.name == 'read');
      await srs.recordReview(cardId: read.id, rating: Rating.good);
      await srs.recordReview(cardId: read.id, rating: Rating.again);
      now = now.add(const Duration(days: 1));
      await srs.recordReview(cardId: read.id, rating: Rating.good);

      final p = await stats.profile();
      expect(p.streak, 2);
      expect(p.totalXp, 10 + 2 + 10);
      expect(p.todayXp, 10);
      expect(p.wordsStudied, 1);
      final acc = p.accuracy.values.single;
      expect((acc.correct, acc.total), (2, 3));
    });

    test('xuất → xoá → nhập lại khôi phục đủ tiến độ', () async {
      final read = (await db.select(db.cards).get()).first;
      await srs.recordReview(cardId: read.id, rating: Rating.good, durationMs: 1234);
      await settings.setDailyNewLimit(25);
      await db.into(db.lessonProgress).insert(
          LessonProgressCompanion.insert(lessonId: 'l1', bestScore: const Value(90)));

      final backup = BackupRepository(db, clock: () => now);
      final raw = await backup.exportString();
      final beforeCards = await db.select(db.cards).get();

      // Mất dữ liệu (vd cài lại app).
      await db.delete(db.reviewLogs).go();
      await db.delete(db.cards).go();
      await db.delete(db.settings).go();
      await db.delete(db.lessonProgress).go();

      final n = await backup.import(raw);
      expect(n, beforeCards.length);
      expect(await db.select(db.cards).get(), beforeCards);
      expect((await db.select(db.reviewLogs).getSingle()).durationMs, 1234);
      expect(await settings.dailyNewLimit(), 25);
      expect((await db.select(db.lessonProgress).getSingle()).bestScore, 90);
      // Nội dung học không bị đụng tới.
      expect(await db.select(db.words).get(), hasLength(1));
    });

    test('file không hợp lệ → báo lỗi, dữ liệu cũ còn nguyên', () async {
      final backup = BackupRepository(db);
      final before = await db.select(db.cards).get();
      expect(() => backup.import('not json'), throwsA(isA<BackupFormatException>()));
      expect(() => backup.import(jsonEncode({'app': 'other'})),
          throwsA(isA<BackupFormatException>()));
      expect(
        () => backup.import(jsonEncode({
          'app': BackupRepository.appId,
          'format': 1,
          'tables': {
            'cards': [
              {'id': 'hỏng'},
            ],
          },
        })),
        throwsA(isA<BackupFormatException>()),
      );
      expect(await db.select(db.cards).get(), before);
    });
  });
}
