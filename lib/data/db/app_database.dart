import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

export 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Words,
    Lessons,
    GrammarPoints,
    ContentVersions,
    Cards,
    ReviewLogs,
    LessonProgress,
    DailyStats,
    Settings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'simple_chinese'));

  /// Tăng số này mỗi khi đổi schema, rồi thêm bước tương ứng trong
  /// [MigrationStrategy.onUpgrade]. Có thể dùng `dart run drift_dev
  /// make-migrations` để sinh snapshot schema và test migration tự động.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIndexes();
        },
        onUpgrade: (m, from, to) async {
          // Chạy tuần tự từng bước để người dùng nhảy nhiều phiên bản vẫn đúng.
          // Ví dụ khi lên schema 2:
          // if (from < 2) await m.addColumn(cards, cards.someNewColumn);
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_words_lesson ON words (lesson_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_words_pinyin_plain ON words (pinyin_plain)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_cards_due ON cards (due)',
    );
  }
}
