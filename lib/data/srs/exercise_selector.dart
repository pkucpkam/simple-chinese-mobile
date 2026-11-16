import '../models/srs_card.dart';

/// Các dạng bài tập trong phiên ôn.
enum ExerciseType {
  /// Thẻ lật — dùng để giới thiệu thẻ mới.
  flashcard,

  /// Nhìn chữ Hán, chọn nghĩa tiếng Việt (4 lựa chọn).
  meaningChoice,

  /// Nghe audio, chọn chữ Hán (4 lựa chọn).
  listenChoice,

  /// Ghép 4–5 cặp chữ Hán ↔ nghĩa, có bấm giờ (gộp nhiều thẻ).
  matching,

  /// Gõ pinyin có số thanh: "ni3 hao3".
  typePinyin,

  /// Nghe một từ, chọn cách viết pinyin có thanh đúng trong 4 phương án.
  toneChoice,

  /// Viết chữ từ trí nhớ (thẻ kỹ năng viết).
  write,

  /// Sắp xếp câu (dùng trong bài học).
  sentenceOrder,
}

/// Chọn dạng bài theo độ "chắc" (stability, đơn vị ngày) của thẻ:
/// thẻ yếu → nhận diện (trắc nghiệm), thẻ mạnh → nhớ lại chủ động (gõ / viết).
class ExerciseSelector {
  const ExerciseSelector({this.available = implemented});

  /// Dạng bài đã có UI. Khi một dạng chưa có, selector lùi về dạng dễ hơn.
  static const implemented = {
    ExerciseType.flashcard,
    ExerciseType.meaningChoice,
    ExerciseType.listenChoice,
    ExerciseType.matching,
    ExerciseType.typePinyin,
    ExerciseType.toneChoice,
    ExerciseType.write,
  };

  /// Dưới ngưỡng này (ngày) coi là thẻ yếu.
  static const weakBelow = 3.0;

  /// Từ ngưỡng này (ngày) coi là thẻ mạnh.
  static const strongFrom = 10.0;

  final Set<ExerciseType> available;

  ExerciseType select(SrsCard card) {
    // Thẻ đọc mới: giới thiệu từ bằng flashcard. Thẻ kỹ năng khác (nghe,
    // thanh…) chỉ mở sau khi đã học thẻ đọc, nên vào thẳng bài tập dạng dễ.
    if (card.isNew && card.skill == CardSkill.read) return ExerciseType.flashcard;

    // Thẻ vừa quên / đang học lại luôn coi là yếu, bất kể stability.
    final weak = card.isNew ||
        card.state != CardState.review ||
        card.stability < weakBelow;
    final strong = !weak && card.stability >= strongFrom;

    final preferred = switch (card.skill) {
      CardSkill.read => weak
          ? [ExerciseType.meaningChoice]
          : strong
              ? [ExerciseType.typePinyin, ExerciseType.matching]
              : [ExerciseType.matching, ExerciseType.meaningChoice],
      CardSkill.listen => [ExerciseType.listenChoice],
      CardSkill.tone => [ExerciseType.toneChoice, ExerciseType.listenChoice],
      CardSkill.write => strong
          ? [ExerciseType.write, ExerciseType.typePinyin]
          : [ExerciseType.write, ExerciseType.meaningChoice],
    };

    for (final t in [...preferred, ExerciseType.meaningChoice, ExerciseType.flashcard]) {
      if (available.contains(t)) return t;
    }
    return ExerciseType.flashcard;
  }
}
