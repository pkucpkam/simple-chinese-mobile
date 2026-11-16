import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/utils/clock.dart';
import '../content/content_models.dart';
import '../db/app_database.dart';
import '../models/lesson.dart';
import 'srs_repository.dart';
import 'stats_repository.dart';
import 'word_repository.dart';

/// Kết quả khi hoàn thành quiz của một bài.
class LessonResult {
  const LessonResult({
    required this.score,
    required this.passed,
    required this.newBest,
    required this.xp,
    required this.unlockedNext,
  });

  final int score;
  final bool passed;
  final bool newBest;
  final int xp;

  /// Lần đầu qua bài → bài kế tiếp vừa được mở khoá.
  final bool unlockedNext;
}

class LessonRepository {
  LessonRepository(
    this._db, {
    required SrsRepository srs,
    required StatsRepository stats,
    DateTime Function()? clock,
  })  : _srs = srs,
        _stats = stats,
        _now = clock ?? AppClock.now;

  final AppDatabase _db;
  final SrsRepository _srs;
  final StatsRepository _stats;
  final DateTime Function() _now;

  /// XP cho mỗi lần qua bài (thưởng thêm lần đầu).
  static const xpPass = 30;
  static const xpFirstPass = 50;

  Stream<List<LessonSummary>> watchLessons(int level) =>
      (_db.select(_db.lessons)
            ..where((t) => t.level.equals(level))
            ..orderBy([(t) => OrderingTerm(expression: t.order)]))
          .watch()
          .map((rows) => rows.map(_toSummary).toList());

  /// Lộ trình: bài học + tiến độ + trạng thái khoá. Phát lại khi tiến độ đổi.
  Stream<List<LessonNode>> watchPath(int level) {
    final trigger = _db
        .customSelect('SELECT 1', readsFrom: {_db.lessons, _db.lessonProgress, _db.words})
        .watch();
    return trigger.asyncMap((_) => _path(level));
  }

  Future<List<LessonNode>> _path(int level) async {
    final lessons = await (_db.select(_db.lessons)
          ..where((t) => t.level.equals(level))
          ..orderBy([(t) => OrderingTerm(expression: t.order)]))
        .get();
    final progress = {
      for (final p in await _db.select(_db.lessonProgress).get()) p.lessonId: p,
    };
    final counts = <String, int>{};
    for (final w in await (_db.select(_db.words)..where((t) => t.level.equals(level))).get()) {
      counts[w.lessonId] = (counts[w.lessonId] ?? 0) + 1;
    }

    final nodes = <LessonNode>[];
    var previousPassed = true; // bài đầu luôn mở
    for (final l in lessons) {
      final p = progress[l.id];
      final node = LessonNode(
        lesson: _toSummary(l),
        wordCount: counts[l.id] ?? 0,
        bestScore: p?.bestScore ?? 0,
        completedAt: p?.completedAt,
        unlocked: previousPassed,
      );
      nodes.add(node);
      previousPassed = node.passed;
    }
    return nodes;
  }

  Future<LessonDetail> detail(String lessonId) async {
    final row = await (_db.select(_db.lessons)..where((t) => t.id.equals(lessonId)))
        .getSingle();
    final json = jsonDecode(row.contentJson) as Map<String, dynamic>;
    final words = await (_db.select(_db.words)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
    final grammar = await (_db.select(_db.grammarPoints)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
    return LessonDetail(
      lesson: _toSummary(row),
      words: words.map(WordRepository.toWord).toList(),
      grammar: [
        for (final g in grammar)
          GrammarContent.fromJson(jsonDecode(g.contentJson) as Map<String, dynamic>),
      ],
      dialogue: [
        for (final d in (json['dialogue'] as List? ?? const []))
          DialogueLine.fromJson(d as Map<String, dynamic>),
      ],
      sentences: [
        for (final s in (json['sentences'] as List? ?? const []))
          OrderSentence.fromJson(s as Map<String, dynamic>),
      ],
    );
  }

  /// Ghi kết quả quiz. Đạt ≥ [kPassScore]: lưu thời điểm hoàn thành, thêm từ
  /// của bài vào bộ thẻ ôn tập (không trùng lặp) và cộng XP.
  Future<LessonResult> complete(String lessonId, int score) {
    return _db.transaction(() async {
      final old = await (_db.select(_db.lessonProgress)
            ..where((t) => t.lessonId.equals(lessonId)))
          .getSingleOrNull();
      final passed = score >= kPassScore;
      final firstPass = passed && (old?.completedAt == null);
      final best = old == null || score > old.bestScore ? score : old.bestScore;

      await _db.into(_db.lessonProgress).insertOnConflictUpdate(
            LessonProgressCompanion.insert(
              lessonId: lessonId,
              bestScore: Value(best),
              completedAt: Value(old?.completedAt ?? (passed ? _now() : null)),
            ),
          );

      var xp = 0;
      if (passed) {
        final words = await (_db.select(_db.words)
              ..where((t) => t.lessonId.equals(lessonId)))
            .get();
        await _srs.addWordsForStudy(words.map(WordRepository.toWord));
        xp = firstPass ? xpFirstPass : xpPass;
        await _stats.add(xp: xp);
      }
      return LessonResult(
        score: score,
        passed: passed,
        newBest: old == null || score > old.bestScore,
        xp: xp,
        unlockedNext: firstPass,
      );
    });
  }

  static LessonSummary _toSummary(LessonRow r) {
    final json = jsonDecode(r.contentJson) as Map<String, dynamic>;
    return LessonSummary(
      id: r.id,
      level: r.level,
      order: r.order,
      title: r.title,
      subtitle: json['subtitle'] as String? ?? '',
    );
  }
}
