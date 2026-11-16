// Định nghĩa bảng Drift.
//
// Hai nhóm bảng tách biệt rõ ràng:
// - NỘI DUNG (chỉ đọc, import từ JSON, có thể bị ghi đè khi contentVersion tăng):
//   words, lessons, grammar_points, content_versions.
// - TIẾN ĐỘ người học (không bao giờ bị import ghi đè):
//   cards, review_logs, lesson_progress, daily_stats, settings.
// Tiến độ chỉ tham chiếu nội dung qua id dạng chuỗi ổn định ("hsk1-001"),
// nên import lại nội dung không làm mất tiến độ.
import 'package:drift/drift.dart';

// ---------------------------------------------------------------- Nội dung

@DataClassName('WordRow')
class Words extends Table {
  TextColumn get id => text()();
  TextColumn get hanzi => text()();

  /// Pinyin có dấu, tách âm tiết: "lǎo shī".
  TextColumn get pinyin => text()();

  /// Pinyin không dấu, không cách, chữ thường ("laoshi") để tìm kiếm nhanh.
  TextColumn get pinyinPlain => text()();
  TextColumn get hanViet => text()();
  TextColumn get meaningVi => text()();
  IntColumn get level => integer()();
  TextColumn get lessonId => text()();
  BoolColumn get mustWrite => boolean().withDefault(const Constant(false))();
  TextColumn get audioPath => text().nullable()();

  /// JSON mảng [{hanzi, pinyin, vi}].
  TextColumn get examplesJson => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LessonRow')
class Lessons extends Table {
  TextColumn get id => text()();
  IntColumn get level => integer()();
  IntColumn get order => integer().named('sort_order')();
  TextColumn get title => text()();

  /// Toàn bộ object bài học dạng JSON (hội thoại, bài luyện...).
  TextColumn get contentJson => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GrammarRow')
class GrammarPoints extends Table {
  TextColumn get id => text()();
  IntColumn get level => integer()();
  TextColumn get lessonId => text()();
  TextColumn get title => text()();
  TextColumn get contentJson => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Phiên bản nội dung đã import, khoá là `pack/kind` vd "hsk1/words".
@DataClassName('ContentVersionRow')
class ContentVersions extends Table {
  TextColumn get source => text()();
  IntColumn get version => integer()();
  DateTimeColumn get importedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {source};
}

// ---------------------------------------------------------------- Tiến độ

/// Kỹ năng của một thẻ. Mỗi từ có thể có nhiều thẻ (mỗi kỹ năng một thẻ).
enum CardSkill { read, listen, tone, write }

@DataClassName('CardRow')
class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Không đặt khoá ngoại tới words: nếu một từ bị gỡ khỏi nội dung,
  /// thẻ vẫn được giữ (và bị lọc khi join) thay vì mất lịch sử ôn tập.
  TextColumn get wordId => text()();
  TextColumn get skill => textEnum<CardSkill>()();

  // Các trường FSRS.
  RealColumn get stability => real().withDefault(const Constant(0))();
  RealColumn get difficulty => real().withDefault(const Constant(0))();
  DateTimeColumn get due => dateTime()();

  /// Trạng thái FSRS: 0 new, 1 learning, 2 review, 3 relearning.
  IntColumn get state => integer().withDefault(const Constant(0))();
  IntColumn get step => integer().nullable()();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastReview => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {wordId, skill},
      ];
}

@DataClassName('ReviewLogRow')
class ReviewLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId =>
      integer().references(Cards, #id, onDelete: KeyAction.cascade)();

  /// 1 Again, 2 Hard, 3 Good, 4 Easy.
  IntColumn get rating => integer()();
  DateTimeColumn get reviewedAt => dateTime()();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
}

@DataClassName('LessonProgressRow')
class LessonProgress extends Table {
  TextColumn get lessonId => text()();
  IntColumn get bestScore => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {lessonId};
}

@DataClassName('DailyStatRow')
class DailyStats extends Table {
  /// Ngày địa phương dạng "yyyy-MM-dd".
  TextColumn get date => text()();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  IntColumn get reviews => integer().withDefault(const Constant(0))();
  IntColumn get newCards => integer().withDefault(const Constant(0))();
  IntColumn get minutes => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {date};
}

/// Cài đặt key-value (chủ đề, số thẻ mới/ngày, giờ nhắc...).
@DataClassName('SettingRow')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
