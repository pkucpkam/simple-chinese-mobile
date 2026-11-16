import '../../../data/models/srs_card.dart';
import '../../../data/models/word.dart';
import '../../../data/srs/exercise_selector.dart';

/// Một bước trong phiên ôn. Phần lớn bài tập ứng với 1 thẻ; riêng ghép cặp
/// gộp nhiều thẻ vào một bước.
sealed class SessionTask {
  const SessionTask();

  ExerciseType get type;

  /// Các thẻ được chấm trong bước này.
  List<StudyItem> get items;
}

final class FlashcardTask extends SessionTask {
  const FlashcardTask(this.item);
  final StudyItem item;

  @override
  ExerciseType get type => ExerciseType.flashcard;
  @override
  List<StudyItem> get items => [item];
}

/// Trắc nghiệm: nhìn chữ chọn nghĩa, hoặc nghe chọn chữ.
final class ChoiceTask extends SessionTask {
  const ChoiceTask(this.type, this.item, this.options)
      : assert(type == ExerciseType.meaningChoice ||
            type == ExerciseType.listenChoice);

  @override
  final ExerciseType type;
  final StudyItem item;

  /// Các lựa chọn (đã trộn), luôn chứa đúng 1 lần `item.word`.
  final List<Word> options;

  @override
  List<StudyItem> get items => [item];
}

/// Nghe một từ, chọn pinyin có thanh đúng.
final class ToneChoiceTask extends SessionTask {
  const ToneChoiceTask(this.item, this.options);
  final StudyItem item;

  /// Các phương án pinyin (đã trộn), chứa đúng 1 lần `item.word.pinyin`.
  final List<String> options;

  @override
  ExerciseType get type => ExerciseType.toneChoice;
  @override
  List<StudyItem> get items => [item];
}

/// Viết chữ Hán của từ từ trí nhớ.
final class WriteTask extends SessionTask {
  const WriteTask(this.item);
  final StudyItem item;

  @override
  ExerciseType get type => ExerciseType.write;
  @override
  List<StudyItem> get items => [item];
}

final class TypePinyinTask extends SessionTask {
  const TypePinyinTask(this.item);
  final StudyItem item;

  @override
  ExerciseType get type => ExerciseType.typePinyin;
  @override
  List<StudyItem> get items => [item];
}

final class MatchingTask extends SessionTask {
  const MatchingTask(this.items);

  @override
  final List<StudyItem> items;

  @override
  ExerciseType get type => ExerciseType.matching;
}
