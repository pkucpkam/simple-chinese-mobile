import 'dart:convert';

import 'package:drift/drift.dart';

import '../content/content_models.dart';
import '../db/app_database.dart';
import '../models/word.dart';

/// Truy cập từ vựng (nội dung chỉ đọc).
class WordRepository {
  WordRepository(this._db);

  final AppDatabase _db;

  Stream<Word?> watchWord(String id) =>
      (_db.select(_db.words)..where((t) => t.id.equals(id)))
          .watchSingleOrNull()
          .map((row) => row == null ? null : toWord(row));

  Stream<List<Word>> watchByLevel(int level) =>
      (_db.select(_db.words)
            ..where((t) => t.level.equals(level))
            ..orderBy([(t) => OrderingTerm(expression: t.id)]))
          .watch()
          .map((rows) => rows.map(toWord).toList());

  Future<List<Word>> byLesson(String lessonId) async {
    final rows = await (_db.select(_db.words)
          ..where((t) => t.lessonId.equals(lessonId))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
    return rows.map(toWord).toList();
  }

  /// Toàn bộ từ của một cấp độ (dùng làm nguồn đáp án nhiễu cho trắc nghiệm).
  Future<List<Word>> byLevel(int level) async {
    final rows = await (_db.select(_db.words)
          ..where((t) => t.level.equals(level)))
        .get();
    return rows.map(toWord).toList();
  }

  Future<int> count() => _db.words.count().getSingle();

  static Word toWord(WordRow r) => Word(
        id: r.id,
        hanzi: r.hanzi,
        pinyin: r.pinyin,
        hanViet: r.hanViet,
        meaningVi: r.meaningVi,
        level: r.level,
        lessonId: r.lessonId,
        mustWrite: r.mustWrite,
        audioPath: r.audioPath,
        examples: (jsonDecode(r.examplesJson) as List)
            .map((e) => ExampleSentence.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
