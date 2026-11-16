import 'dart:convert';

import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../models/lesson.dart';

class LessonRepository {
  LessonRepository(this._db);

  final AppDatabase _db;

  Stream<List<LessonSummary>> watchLessons(int level) =>
      (_db.select(_db.lessons)
            ..where((t) => t.level.equals(level))
            ..orderBy([(t) => OrderingTerm(expression: t.order)]))
          .watch()
          .map((rows) => rows.map(_toSummary).toList());

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
