// Model cho file nội dung JSON (chỉ đọc) trong assets/content/<level>/.
//
// Mỗi file có dạng: { "contentVersion": 1, "level": 1, "items": [...] }.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_models.freezed.dart';
part 'content_models.g.dart';

/// Câu ví dụ / dòng hội thoại dùng chung.
@freezed
abstract class ExampleSentence with _$ExampleSentence {
  const factory ExampleSentence({
    required String hanzi,
    required String pinyin,
    required String vi,
  }) = _ExampleSentence;

  factory ExampleSentence.fromJson(Map<String, dynamic> json) =>
      _$ExampleSentenceFromJson(json);
}

@freezed
abstract class WordContent with _$WordContent {
  const factory WordContent({
    required String id,
    required String hanzi,

    /// Pinyin có dấu, tách âm tiết bằng dấu cách: "lǎo shī".
    required String pinyin,
    required String hanViet,
    required String meaningVi,
    required String lessonId,
    @Default(false) bool mustWrite,

    /// Đường dẫn asset audio (vd "assets/audio/hsk1/ni3.mp3"); null → dùng TTS.
    String? audio,
    @Default(<ExampleSentence>[]) List<ExampleSentence> examples,
  }) = _WordContent;

  factory WordContent.fromJson(Map<String, dynamic> json) =>
      _$WordContentFromJson(json);
}

/// Bài học. Chỉ các trường dùng để sắp xếp/hiển thị danh sách được tách cột;
/// phần còn lại (hội thoại, bài luyện...) lưu nguyên JSON trong `contentJson`
/// để có thể mở rộng cấu trúc bài học mà không cần migration DB.
@freezed
abstract class LessonContent with _$LessonContent {
  const factory LessonContent({
    required String id,
    required int order,
    required String title,
    @Default('') String subtitle,
  }) = _LessonContent;

  factory LessonContent.fromJson(Map<String, dynamic> json) =>
      _$LessonContentFromJson(json);
}

@freezed
abstract class GrammarContent with _$GrammarContent {
  const factory GrammarContent({
    required String id,
    required String lessonId,
    required String title,
    required String pattern,
    required String explanationVi,
    @Default(<ExampleSentence>[]) List<ExampleSentence> examples,
  }) = _GrammarContent;

  factory GrammarContent.fromJson(Map<String, dynamic> json) =>
      _$GrammarContentFromJson(json);
}

/// Phần "vỏ" chung của mọi file nội dung.
class ContentFile {
  const ContentFile({
    required this.contentVersion,
    required this.level,
    required this.items,
  });

  final int contentVersion;
  final int level;
  final List<Map<String, dynamic>> items;

  factory ContentFile.fromJson(Map<String, dynamic> json) {
    final version = json['contentVersion'];
    final level = json['level'];
    if (version is! int || level is! int || json['items'] is! List) {
      throw const FormatException(
        'File nội dung thiếu contentVersion/level/items',
      );
    }
    return ContentFile(
      contentVersion: version,
      level: level,
      items: (json['items'] as List).cast<Map<String, dynamic>>(),
    );
  }
}

/// Loại file nội dung trong mỗi thư mục cấp độ.
enum ContentKind {
  words('words.json'),
  lessons('lessons.json'),
  grammar('grammar.json');

  const ContentKind(this.fileName);
  final String fileName;
}
