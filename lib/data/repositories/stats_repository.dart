import 'package:drift/drift.dart';

import '../../core/utils/clock.dart';
import '../../core/utils/dates.dart';
import '../db/app_database.dart';
import '../models/profile_stats.dart';

/// Thống kê theo ngày (XP, lượt ôn, thẻ mới, phút học) trong bảng daily_stats.
class StatsRepository {
  StatsRepository(this._db, {DateTime Function()? clock})
      : _now = clock ?? AppClock.now;

  final AppDatabase _db;
  final DateTime Function() _now;

  /// Cộng dồn vào dòng của ngày hôm nay (tạo mới nếu chưa có).
  Future<void> add({
    int xp = 0,
    int reviews = 0,
    int newCards = 0,
    int minutes = 0,
  }) {
    return _db.into(_db.dailyStats).insert(
          DailyStatsCompanion.insert(
            date: dayKey(_now()),
            xp: Value(xp),
            reviews: Value(reviews),
            newCards: Value(newCards),
            minutes: Value(minutes),
          ),
          onConflict: DoUpdate(
            (old) => DailyStatsCompanion.custom(
              xp: old.xp + Constant(xp),
              reviews: old.reviews + Constant(reviews),
              newCards: old.newCards + Constant(newCards),
              minutes: old.minutes + Constant(minutes),
            ),
          ),
        );
  }

  Future<DailyStatRow> today() async {
    final key = dayKey(_now());
    return await (_db.select(_db.dailyStats)..where((t) => t.date.equals(key)))
            .getSingleOrNull() ??
        DailyStatRow(date: key, xp: 0, reviews: 0, newCards: 0, minutes: 0);
  }

  /// Thống kê hồ sơ; phát lại khi daily_stats / review_logs / cards đổi.
  Stream<ProfileStats> watchProfile() => _db
      .customSelect('SELECT 1', readsFrom: {_db.dailyStats, _db.reviewLogs, _db.cards})
      .watch()
      .asyncMap((_) => profile());

  Future<ProfileStats> profile() async {
    final now = _now();
    final rows = await _db.select(_db.dailyStats).get();
    final days = {
      for (final r in rows)
        r.date: DayActivity(xp: r.xp, reviews: r.reviews, minutes: r.minutes),
    };
    final active = {
      for (final e in days.entries)
        if (e.value.active) DateTime.parse(e.key),
    };
    final (streak, best) = computeStreak(active, now);

    // Độ chính xác theo kỹ năng: lượt không bị Again (rating > 1) / tổng.
    final acc = await _db.customSelect(
      'SELECT c.skill AS skill, COUNT(*) AS total, '
      'SUM(CASE WHEN r.rating > 1 THEN 1 ELSE 0 END) AS correct '
      'FROM review_logs r JOIN cards c ON c.id = r.card_id GROUP BY c.skill',
      readsFrom: {_db.reviewLogs, _db.cards},
    ).get();
    final accuracy = {
      for (final r in acc)
        CardSkill.values.byName(r.read<String>('skill')):
            SkillAccuracy(correct: r.read<int>('correct'), total: r.read<int>('total')),
    };

    final studied = await _db.customSelect(
      'SELECT COUNT(DISTINCT word_id) AS n FROM cards WHERE state != 0',
      readsFrom: {_db.cards},
    ).getSingle();

    return ProfileStats(
      streak: streak,
      bestStreak: best,
      totalXp: rows.fold(0, (s, r) => s + r.xp),
      todayXp: days[dayKey(now)]?.xp ?? 0,
      totalMinutes: rows.fold(0, (s, r) => s + r.minutes),
      wordsStudied: studied.read<int>('n'),
      days: days,
      accuracy: accuracy,
    );
  }
}
