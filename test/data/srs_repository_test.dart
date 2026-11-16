import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:simple_chinese/core/utils/dates.dart';
import 'package:simple_chinese/data/db/app_database.dart';
import 'package:simple_chinese/data/models/srs_card.dart';
import 'package:simple_chinese/data/repositories/settings_repository.dart';
import 'package:simple_chinese/data/repositories/srs_repository.dart';
import 'package:simple_chinese/data/srs/srs_scheduler.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settings;
  late SrsRepository repo;
  late DateTime now;

  Future<void> seedWords(int n) async {
    await db.batch((b) {
      for (var i = 0; i < n; i++) {
        b.insert(db.words, WordsCompanion.insert(
          id: 'w$i',
          hanzi: '字$i',
          pinyin: 'zì',
          pinyinPlain: 'zi',
          hanViet: 'tự',
          meaningVi: 'nghĩa $i',
          level: 1,
          lessonId: 'l1',
        ));
      }
    });
  }

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    settings = SettingsRepository(db);
    now = DateTime(2026, 3, 10, 9); // giờ địa phương
    repo = SrsRepository(
      db,
      settings,
      scheduler: SrsScheduler(scheduler: fsrs.Scheduler(enableFuzzing: false)),
      clock: () => now,
    );
    await seedWords(30);
  });
  tearDown(() => db.close());

  test('addWords tạo thẻ read + listen + tone, thêm lại không nhân đôi', () async {
    await repo.addWords(['w0', 'w1']);
    await repo.addWords(['w0']);
    final cards = await db.select(db.cards).get();
    expect(cards, hasLength(6));
    expect(cards.map((c) => c.skill).toSet(),
        {CardSkill.read, CardSkill.listen, CardSkill.tone});
  });

  test('hàng đợi tôn trọng giới hạn thẻ mới mỗi ngày', () async {
    await settings.setDailyNewLimit(5);
    await repo.addWords([for (var i = 0; i < 20; i++) 'w$i']);

    final queue = await repo.buildQueue();
    expect(queue, hasLength(5));
    // Thẻ listen chưa được mở vì thẻ read cùng từ chưa học.
    expect(queue.every((i) => i.card.skill == CardSkill.read), isTrue);

    // Học 3 thẻ → còn 2 suất.
    for (final item in queue.take(3)) {
      await repo.recordReview(cardId: item.card.id, rating: Rating.good);
    }
    final stats = await repo.stats();
    expect(stats.newToday, 3);
    expect(stats.newAvailable, 2);
  });

  test('recordReview cập nhật FSRS, ghi log và daily_stats', () async {
    await repo.addWords(['w0']);
    final item = (await repo.buildQueue()).first;

    final after = await repo.recordReview(
      cardId: item.card.id,
      rating: Rating.good,
      durationMs: 2500,
    );
    expect(after.state, CardState.learning);
    expect(after.reps, 1);

    final row = await (db.select(db.cards)..where((t) => t.id.equals(item.card.id)))
        .getSingle();
    expect(row.state, CardState.learning.value);
    expect(row.stability, greaterThan(0));

    final log = await db.select(db.reviewLogs).getSingle();
    expect(log.rating, 3);
    expect(log.durationMs, 2500);

    final day = await db.select(db.dailyStats).getSingle();
    expect(day.date, dayKey(now));
    expect(day.reviews, 1);
    expect(day.newCards, 1);
    expect(day.xp, SrsRepository.xpFor(Rating.good));
  });

  test('thẻ đến hạn vào hàng đợi; thẻ chưa đến hạn thì không', () async {
    await settings.setDailyNewLimit(0);
    await repo.addWords(['w0']);
    final card = (await db.select(db.cards).get())
        .firstWhere((c) => c.skill == CardSkill.read);
    await repo.recordReview(cardId: card.id, rating: Rating.easy); // vài ngày sau

    expect(await repo.buildQueue(), isEmpty);

    now = now.add(const Duration(days: 30));
    final queue = await repo.buildQueue();
    expect(queue.single.card.id, card.id);
    expect((await repo.stats()).due, 1);
  });

  test('thẻ listen chỉ mở từ ngày hôm sau khi đã học thẻ read', () async {
    await repo.addWords(['w0']);
    final read = (await repo.buildQueue()).single;
    await repo.recordReview(cardId: read.card.id, rating: Rating.easy);

    expect((await repo.buildQueue()).where((i) => i.card.skill == CardSkill.listen),
        isEmpty);

    now = now.add(const Duration(days: 1));
    final queue = await repo.buildQueue();
    expect(queue.any((i) => i.card.skill == CardSkill.listen), isTrue);
  });

  test('thẻ mới được rải xen giữa thẻ ôn', () async {
    await settings.setDailyNewLimit(0);
    await repo.addWords([for (var i = 0; i < 6; i++) 'w$i']);
    for (final c in await db.select(db.cards).get()) {
      if (c.skill == CardSkill.read) {
        await repo.recordReview(cardId: c.id, rating: Rating.again);
      }
    }
    await settings.setDailyNewLimit(10);
    await repo.addWords(['w10', 'w11']);
    now = now.add(const Duration(hours: 1));

    final queue = await repo.buildQueue();
    final pattern = queue.map((i) => i.card.isNew ? 'N' : 'R').join();
    expect(pattern, 'RRRNRRRN');
  });

  test('addStudyMinutes cộng dồn vào ngày', () async {
    await repo.addStudyMinutes(3);
    await repo.addStudyMinutes(2);
    expect((await db.select(db.dailyStats).getSingle()).minutes, 5);
  });
}
