import 'package:drift/drift.dart';

import '../../core/utils/clock.dart';
import '../../core/utils/dates.dart';
import '../db/app_database.dart';
import '../models/srs_card.dart';
import '../models/word.dart';
import '../srs/srs_scheduler.dart';
import 'settings_repository.dart';
import 'stats_repository.dart';
import 'word_repository.dart';

/// Bộ thẻ ôn tập: thêm thẻ, dựng hàng đợi, ghi kết quả ôn theo FSRS.
class SrsRepository {
  SrsRepository(
    this._db,
    this._settings, {
    SrsScheduler? scheduler,
    StatsRepository? stats,
    DateTime Function()? clock,
  })  : _scheduler = scheduler ?? SrsScheduler(),
        _now = clock ?? AppClock.now,
        _stats = stats ?? StatsRepository(_db, clock: clock);

  final AppDatabase _db;
  final SettingsRepository _settings;
  final SrsScheduler _scheduler;
  final StatsRepository _stats;
  final DateTime Function() _now;

  SrsScheduler get scheduler => _scheduler;

  /// Kỹ năng mặc định được tạo khi thêm một từ vào bộ thẻ.
  static const defaultSkills = [CardSkill.read, CardSkill.listen, CardSkill.tone];

  /// Thêm từ vào bộ thẻ với kỹ năng phù hợp: mọi từ có thẻ đọc/nghe/thanh,
  /// từ cần biết viết (mustWrite) có thêm thẻ viết.
  Future<void> addWordsForStudy(Iterable<Word> words) async {
    await addWords(words.map((w) => w.id));
    await addWords(
      words.where((w) => w.mustWrite).map((w) => w.id),
      skills: const [CardSkill.write],
    );
  }

  // ------------------------------------------------------------ Bộ thẻ

  /// Thêm từ vào bộ thẻ. Thẻ đã có thì bỏ qua (giữ nguyên tiến độ).
  Future<void> addWords(
    Iterable<String> wordIds, {
    List<CardSkill> skills = defaultSkills,
  }) async {
    final now = _now();
    await _db.batch((b) {
      for (final id in wordIds) {
        for (final skill in skills) {
          b.insert(
            _db.cards,
            CardsCompanion.insert(
              wordId: id,
              skill: skill,
              due: now,
              createdAt: Value(now),
            ),
            mode: InsertMode.insertOrIgnore, // unique(wordId, skill)
          );
        }
      }
    });
  }

  Stream<bool> watchInDeck(String wordId) =>
      (_db.select(_db.cards)..where((t) => t.wordId.equals(wordId)))
          .watch()
          .map((rows) => rows.isNotEmpty);

  // ------------------------------------------------------------ Thống kê

  Stream<DeckStats> watchStats() {
    // Phát lại mỗi khi cards / daily_stats / settings (giới hạn thẻ mới) đổi.
    final trigger = _db
        .customSelect('SELECT 1', readsFrom: {_db.cards, _db.dailyStats, _db.settings})
        .watch();
    return trigger.asyncMap((_) => stats());
  }

  Future<DeckStats> stats() async {
    final now = _now();
    final cards = await _db.select(_db.cards).get();
    final today = await _stats.today();
    final limit = await _settings.dailyNewLimit();
    final eligible = _eligibleNew(cards, now);
    final remaining = (limit - today.newCards).clamp(0, limit);
    return DeckStats(
      due: cards.where((c) => c.state != 0 && !c.due.isAfter(now)).length,
      newAvailable: eligible.length < remaining ? eligible.length : remaining,
      newToday: today.newCards,
      dailyNewLimit: limit,
      total: cards.length,
      reviewsToday: today.reviews,
    );
  }

  // ------------------------------------------------------------ Hàng đợi

  /// Dựng hàng đợi cho một phiên: thẻ đến hạn (theo thứ tự due) + thẻ mới
  /// trong giới hạn còn lại của ngày. Thẻ mới được rải xen giữa thẻ ôn
  /// (cứ [newEvery] thẻ ôn thì chèn 1 thẻ mới) để phiên học không bị dồn.
  Future<List<StudyItem>> buildQueue({
    int maxReviews = 100,
    bool includeNew = true,
    int newEvery = 3,
  }) async {
    final now = _now();
    final all = await _db.select(_db.cards).get();

    final due = all.where((c) => c.state != 0 && !c.due.isAfter(now)).toList()
      ..sort((a, b) => a.due.compareTo(b.due));
    final reviews = due.take(maxReviews).toList();

    var fresh = <CardRow>[];
    if (includeNew) {
      final limit = await _settings.dailyNewLimit();
      final remaining = limit - (await _stats.today()).newCards;
      if (remaining > 0) fresh = _eligibleNew(all, now).take(remaining).toList();
    }

    final ordered = <CardRow>[];
    var r = 0, n = 0;
    while (r < reviews.length || n < fresh.length) {
      for (var i = 0; i < newEvery && r < reviews.length; i++) {
        ordered.add(reviews[r++]);
      }
      if (n < fresh.length) ordered.add(fresh[n++]);
    }
    return _attachWords(ordered);
  }

  /// Thẻ mới được phép giới thiệu. Thẻ kỹ năng khác `read` (listen, tone) chỉ
  /// mở sau khi thẻ `read` cùng từ đã được học từ hôm trước — tránh dồn
  /// nhiều thẻ của cùng một từ vào một ngày.
  List<CardRow> _eligibleNew(List<CardRow> all, DateTime now) {
    final dayStart = startOfDay(now);
    final readLearnedBeforeToday = {
      for (final c in all)
        if (c.skill == CardSkill.read &&
            c.state != 0 &&
            c.lastReview != null &&
            c.lastReview!.isBefore(dayStart))
          c.wordId,
    };
    final fresh = all.where((c) => c.state == 0).where((c) =>
        c.skill == CardSkill.read || readLearnedBeforeToday.contains(c.wordId));
    return fresh.toList()
      ..sort((a, b) {
        final byCreated = a.createdAt.compareTo(b.createdAt);
        return byCreated != 0 ? byCreated : a.wordId.compareTo(b.wordId);
      });
  }

  Future<List<StudyItem>> _attachWords(List<CardRow> cards) async {
    if (cards.isEmpty) return [];
    final ids = cards.map((c) => c.wordId).toSet().toList();
    final rows = await (_db.select(_db.words)..where((t) => t.id.isIn(ids))).get();
    final words = {for (final r in rows) r.id: WordRepository.toWord(r)};
    return [
      for (final c in cards)
        // Thẻ của từ đã bị gỡ khỏi nội dung thì bỏ qua (nhưng vẫn giữ trong DB).
        if (words[c.wordId] != null)
          StudyItem(card: toCard(c), word: words[c.wordId]!),
    ];
  }

  // ------------------------------------------------------------ Ghi kết quả

  /// Ghi một lượt ôn: cập nhật lịch FSRS, thêm review_log, cộng daily_stats.
  /// Trả về thẻ sau khi cập nhật.
  Future<SrsCard> recordReview({
    required int cardId,
    required Rating rating,
    int durationMs = 0,
  }) {
    return _db.transaction(() async {
      final now = _now();
      final row = await (_db.select(_db.cards)..where((t) => t.id.equals(cardId)))
          .getSingle();
      final before = toCard(row);
      final after = _scheduler.review(before, rating, now);

      await (_db.update(_db.cards)..where((t) => t.id.equals(cardId))).write(
        CardsCompanion(
          stability: Value(after.stability),
          difficulty: Value(after.difficulty),
          due: Value(after.due),
          state: Value(after.state.value),
          step: Value(after.step),
          reps: Value(after.reps),
          lapses: Value(after.lapses),
          lastReview: Value(after.lastReview),
        ),
      );
      await _db.into(_db.reviewLogs).insert(ReviewLogsCompanion.insert(
            cardId: cardId,
            rating: rating.value,
            reviewedAt: now,
            durationMs: Value(durationMs),
          ));
      await _stats.add(
        xp: xpFor(rating),
        reviews: 1,
        newCards: before.isNew ? 1 : 0,
      );
      return after;
    });
  }

  /// Cộng số phút học vào thống kê ngày (gọi khi kết thúc phiên).
  Future<void> addStudyMinutes(int minutes) =>
      minutes > 0 ? _stats.add(minutes: minutes) : Future.value();

  /// XP cho mỗi lượt ôn.
  static int xpFor(Rating r) => switch (r) {
        Rating.again => 2,
        Rating.hard => 6,
        Rating.good => 10,
        Rating.easy => 12,
      };

  static SrsCard toCard(CardRow r) => SrsCard(
        id: r.id,
        wordId: r.wordId,
        skill: r.skill,
        stability: r.stability,
        difficulty: r.difficulty,
        due: r.due,
        state: CardState.fromValue(r.state),
        step: r.step,
        reps: r.reps,
        lapses: r.lapses,
        lastReview: r.lastReview,
      );
}
