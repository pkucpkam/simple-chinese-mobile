import 'dart:convert';

import '../../core/utils/clock.dart';
import '../db/app_database.dart';

/// Lỗi khi file backup không hợp lệ (để UI báo cho người dùng).
class BackupFormatException implements Exception {
  const BackupFormatException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Xuất / nhập TIẾN ĐỘ người học dưới dạng JSON (không gồm nội dung học —
/// nội dung luôn được import lại từ assets).
///
/// Định dạng:
/// ```json
/// { "app": "simple_chinese", "format": 1, "schemaVersion": 1,
///   "exportedAt": "...", "tables": { "cards": [...], "review_logs": [...],
///   "lesson_progress": [...], "daily_stats": [...], "settings": [...] } }
/// ```
class BackupRepository {
  BackupRepository(this._db, {DateTime Function()? clock}) : _now = clock ?? AppClock.now;

  final AppDatabase _db;
  final DateTime Function() _now;

  static const appId = 'simple_chinese';
  static const format = 1;

  Future<Map<String, dynamic>> export() async {
    return {
      'app': appId,
      'format': format,
      'schemaVersion': _db.schemaVersion,
      'exportedAt': _now().toIso8601String(),
      'tables': {
        'cards': [for (final r in await _db.select(_db.cards).get()) r.toJson()],
        'review_logs': [for (final r in await _db.select(_db.reviewLogs).get()) r.toJson()],
        'lesson_progress': [
          for (final r in await _db.select(_db.lessonProgress).get()) r.toJson(),
        ],
        'daily_stats': [for (final r in await _db.select(_db.dailyStats).get()) r.toJson()],
        'settings': [for (final r in await _db.select(_db.settings).get()) r.toJson()],
      },
    };
  }

  Future<String> exportString() async => const JsonEncoder.withIndent(' ').convert(await export());

  /// Thay toàn bộ tiến độ bằng dữ liệu trong backup (trong 1 transaction:
  /// lỗi giữa chừng thì không mất dữ liệu cũ). Trả về số thẻ đã khôi phục.
  Future<int> import(String raw) async {
    final Map<String, dynamic> json;
    try {
      json = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      throw const BackupFormatException('File không phải JSON hợp lệ');
    }
    if (json['app'] != appId) {
      throw const BackupFormatException('Không phải file backup của Simple Chinese');
    }
    if ((json['format'] as int? ?? 0) > format) {
      throw const BackupFormatException('Backup từ phiên bản app mới hơn, hãy cập nhật app');
    }
    final tables = json['tables'] as Map<String, dynamic>? ?? const {};
    List<Map<String, dynamic>> rows(String name) =>
        (tables[name] as List? ?? const []).cast<Map<String, dynamic>>();

    try {
      final cards = rows('cards').map(CardRow.fromJson).toList();
      final logs = rows('review_logs').map(ReviewLogRow.fromJson).toList();
      final progress = rows('lesson_progress').map(LessonProgressRow.fromJson).toList();
      final daily = rows('daily_stats').map(DailyStatRow.fromJson).toList();
      final settings = rows('settings').map(SettingRow.fromJson).toList();

      await _db.transaction(() async {
        // Xoá con trước cha vì review_logs tham chiếu cards.
        await _db.delete(_db.reviewLogs).go();
        await _db.delete(_db.cards).go();
        await _db.delete(_db.lessonProgress).go();
        await _db.delete(_db.dailyStats).go();
        await _db.delete(_db.settings).go();
        await _db.batch((b) {
          b.insertAll(_db.cards, cards);
          b.insertAll(_db.reviewLogs, logs);
          b.insertAll(_db.lessonProgress, progress);
          b.insertAll(_db.dailyStats, daily);
          b.insertAll(_db.settings, settings);
        });
      });
      return cards.length;
    } on BackupFormatException {
      rethrow;
    } catch (e) {
      throw BackupFormatException('Dữ liệu backup bị hỏng: $e');
    }
  }
}
