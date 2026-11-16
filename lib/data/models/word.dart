import 'package:freezed_annotation/freezed_annotation.dart';

import '../content/content_models.dart';

part 'word.freezed.dart';

/// Từ vựng dùng trong UI (domain model, tách khỏi row của DB).
@freezed
abstract class Word with _$Word {
  const Word._();

  const factory Word({
    required String id,
    required String hanzi,
    required String pinyin,
    required String hanViet,
    required String meaningVi,
    required int level,
    required String lessonId,
    required bool mustWrite,
    String? audioPath,
    @Default(<ExampleSentence>[]) List<ExampleSentence> examples,
  }) = _Word;

  /// Danh sách chữ Hán đơn lẻ (dùng cho viết chữ, tách nét).
  List<String> get chars => hanzi.runes.map(String.fromCharCode).toList();
}
