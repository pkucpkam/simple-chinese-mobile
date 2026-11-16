import 'package:drift/drift.dart';

import '../../core/utils/clock.dart';
import '../../core/utils/dates.dart';
import '../db/app_database.dart';

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
}
