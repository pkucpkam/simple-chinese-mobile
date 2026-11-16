import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../core/pinyin/pinyin.dart';
import '../db/app_database.dart';
import 'content_models.dart';
import 'content_source.dart';

/// Kết quả một lần chạy import, để log / hiển thị / test.
class ImportReport {
  final List<String> imported = [];
  final List<String> upToDate = [];

  bool get changed => imported.isNotEmpty;

  @override
  String toString() => 'ImportReport(imported: $imported, upToDate: $upToDate)';
}

/// Import nội dung JSON vào DB.
///
/// Với mỗi file `<pack>/<kind>.json`:
/// - Nếu chưa import hoặc `contentVersion` trong file > phiên bản đã lưu
///   → upsert toàn bộ items và xoá các mục nội dung đã bị gỡ khỏi file.
/// - Ngược lại bỏ qua (mở app lần sau gần như không tốn chi phí).
///
/// Importer CHỈ ghi vào bảng nội dung (words, lessons, grammar_points,
/// content_versions). Bảng tiến độ (cards, review_logs, ...) không bị đụng
/// tới, nên tăng contentVersion không làm mất tiến độ người học.
class ContentImporter {
  ContentImporter(this._db, this._source);

  final AppDatabase _db;
  final ContentSource _source;

  Future<ImportReport> run() async {
    final report = ImportReport();
    for (final pack in await _source.listPacks()) {
      for (final kind in ContentKind.values) {
        final raw = await _source.read(pack, kind);
        if (raw == null) continue;

        final file = ContentFile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
        final key = '$pack/${kind.name}';
        final stored = await (_db.select(_db.contentVersions)
              ..where((t) => t.source.equals(key)))
            .getSingleOrNull();

        if (stored != null && stored.version >= file.contentVersion) {
          report.upToDate.add(key);
          continue;
        }

        await _db.transaction(() async {
          switch (kind) {
            case ContentKind.words:
              await _importWords(file);
            case ContentKind.lessons:
              await _importLessons(file);
            case ContentKind.grammar:
              await _importGrammar(file);
          }
          await _db.into(_db.contentVersions).insertOnConflictUpdate(
                ContentVersionsCompanion.insert(
                  source: key,
                  version: file.contentVersion,
                  importedAt: DateTime.now(),
                ),
              );
        });
        report.imported.add(key);
        debugPrint('Content imported: $key v${file.contentVersion}');
      }
    }
    return report;
  }

  Future<void> _importWords(ContentFile file) async {
    final words = file.items.map(WordContent.fromJson).toList();
    await _db.batch((b) {
      b.insertAllOnConflictUpdate(_db.words, [
        for (final w in words)
          WordsCompanion.insert(
            id: w.id,
            hanzi: w.hanzi,
            pinyin: w.pinyin,
            pinyinPlain: stripTones(w.pinyin),
            hanViet: w.hanViet,
            meaningVi: w.meaningVi,
            level: file.level,
            lessonId: w.lessonId,
            mustWrite: Value(w.mustWrite),
            audioPath: Value(w.audio),
            examplesJson: Value(
              jsonEncode(w.examples.map((e) => e.toJson()).toList()),
            ),
          ),
      ]);
    });
    // Xoá từ đã bị gỡ khỏi nội dung của level này. Thẻ (cards) của các từ đó
    // vẫn còn trong DB nhưng bị lọc bỏ khi join, nên nếu từ quay lại ở phiên
    // bản sau thì lịch sử ôn tập vẫn còn nguyên.
    final ids = words.map((w) => w.id).toList();
    await (_db.delete(_db.words)
          ..where((t) => t.level.equals(file.level) & t.id.isNotIn(ids)))
        .go();
  }

  Future<void> _importLessons(ContentFile file) async {
    final lessons = [
      for (final item in file.items) (LessonContent.fromJson(item), item),
    ];
    await _db.batch((b) {
      b.insertAllOnConflictUpdate(_db.lessons, [
        for (final (lesson, raw) in lessons)
          LessonsCompanion.insert(
            id: lesson.id,
            level: file.level,
            order: lesson.order,
            title: lesson.title,
            contentJson: jsonEncode(raw),
          ),
      ]);
    });
    final ids = lessons.map((l) => l.$1.id).toList();
    await (_db.delete(_db.lessons)
          ..where((t) => t.level.equals(file.level) & t.id.isNotIn(ids)))
        .go();
  }

  Future<void> _importGrammar(ContentFile file) async {
    final points = [
      for (final item in file.items) (GrammarContent.fromJson(item), item),
    ];
    await _db.batch((b) {
      b.insertAllOnConflictUpdate(_db.grammarPoints, [
        for (final (g, raw) in points)
          GrammarPointsCompanion.insert(
            id: g.id,
            level: file.level,
            lessonId: g.lessonId,
            title: g.title,
            contentJson: jsonEncode(raw),
          ),
      ]);
    });
    final ids = points.map((g) => g.$1.id).toList();
    await (_db.delete(_db.grammarPoints)
          ..where((t) => t.level.equals(file.level) & t.id.isNotIn(ids)))
        .go();
  }
}
