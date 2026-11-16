// Provider tầng data. UI chỉ dùng repository, không dùng AppDatabase trực tiếp.
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'content/content_importer.dart';
import 'content/content_source.dart';
import 'db/app_database.dart';
import 'repositories/lesson_repository.dart';
import 'repositories/pronunciation_repository.dart';
import 'repositories/settings_repository.dart';
import 'repositories/srs_repository.dart';
import 'repositories/word_repository.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
ContentSource contentSource(Ref ref) => AssetContentSource();

/// Chạy import nội dung một lần khi mở app (nhanh nếu không có gì thay đổi).
@Riverpod(keepAlive: true)
Future<ImportReport> contentBootstrap(Ref ref) =>
    ContentImporter(ref.watch(appDatabaseProvider), ref.watch(contentSourceProvider))
        .run();

@Riverpod(keepAlive: true)
WordRepository wordRepository(Ref ref) =>
    WordRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
LessonRepository lessonRepository(Ref ref) =>
    LessonRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SrsRepository srsRepository(Ref ref) => SrsRepository(
      ref.watch(appDatabaseProvider),
      ref.watch(settingsRepositoryProvider),
    );

@Riverpod(keepAlive: true)
PronunciationRepository pronunciationRepository(Ref ref) =>
    PronunciationRepository();
