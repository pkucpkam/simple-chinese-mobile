import 'dart:math';

import '../../../data/models/srs_card.dart';
import '../../../data/models/word.dart';
import '../../../data/srs/exercise_selector.dart';
import 'session_task.dart';

/// Chế độ phiên học.
enum SessionMode {
  /// Chỉ flashcard (lật thẻ, tự đánh giá).
  flashcard,

  /// Trộn nhiều dạng bài, chọn theo độ chắc của thẻ.
  mixed,
}

/// Biến hàng đợi thẻ thành danh sách bài tập. Hàm thuần — truyền [random]
/// cố định để test ra kết quả xác định.
class SessionBuilder {
  SessionBuilder({
    this.selector = const ExerciseSelector(),
    Random? random,
    this.optionCount = 4,
    this.matchingSize = 4,
  }) : _random = random ?? Random();

  final ExerciseSelector selector;
  final Random _random;
  final int optionCount;

  /// Số cặp mỗi ván ghép. Thẻ dư không đủ một ván → đổi sang trắc nghiệm.
  final int matchingSize;

  List<SessionTask> build(
    List<StudyItem> queue, {
    required SessionMode mode,
    required List<Word> pool,
  }) {
    if (mode == SessionMode.flashcard) {
      return [for (final i in queue) FlashcardTask(i)];
    }

    final tasks = <SessionTask>[];
    final matchingBucket = <StudyItem>[];
    // Ván ghép cặp không được chứa 2 thẻ cùng từ hoặc cùng nghĩa.
    bool fitsBucket(StudyItem i) => !matchingBucket.any((m) =>
        m.word.id == i.word.id || m.word.meaningVi == i.word.meaningVi);

    for (final item in queue) {
      final type = selector.select(item.card);
      if (type == ExerciseType.matching && fitsBucket(item)) {
        matchingBucket.add(item);
        if (matchingBucket.length == matchingSize) {
          tasks.add(MatchingTask(List.of(matchingBucket)));
          matchingBucket.clear();
        }
        continue;
      }
      tasks.add(_single(item, type == ExerciseType.matching
          ? ExerciseType.meaningChoice
          : type, pool));
    }
    // Phần dư không đủ ván ghép → trắc nghiệm nghĩa.
    for (final item in matchingBucket) {
      tasks.add(_single(item, ExerciseType.meaningChoice, pool));
    }
    return tasks;
  }

  /// Tạo lại bài cho thẻ vừa trả lời sai, để ôn lại cuối phiên. Luôn dùng
  /// dạng dễ (trắc nghiệm / nghe chọn) vì thẻ vừa quên.
  SessionTask retry(StudyItem item, List<Word> pool) => _single(
        item,
        item.card.skill == CardSkill.listen
            ? ExerciseType.listenChoice
            : ExerciseType.meaningChoice,
        pool,
      );

  SessionTask _single(StudyItem item, ExerciseType type, List<Word> pool) {
    return switch (type) {
      ExerciseType.flashcard => FlashcardTask(item),
      ExerciseType.typePinyin => TypePinyinTask(item),
      ExerciseType.listenChoice ||
      ExerciseType.meaningChoice =>
        ChoiceTask(type, item, options(item.word, pool, type)),
      // Các dạng chưa có UI: selector đã lùi về dạng có sẵn; đây là lưới an toàn.
      _ => ChoiceTask(
          ExerciseType.meaningChoice,
          item,
          options(item.word, pool, ExerciseType.meaningChoice),
        ),
    };
  }

  /// Chọn đáp án nhiễu: khác từ đúng, và không trùng thứ được hiển thị
  /// (nghĩa với trắc nghiệm nghĩa, chữ Hán với nghe chọn chữ) để không có
  /// 2 đáp án giống hệt nhau.
  List<Word> options(Word answer, List<Word> pool, ExerciseType type) {
    String keyOf(Word w) =>
        type == ExerciseType.listenChoice ? w.hanzi : w.meaningVi;
    final seen = {keyOf(answer)};
    final distractors = <Word>[];
    for (final w in List.of(pool)..shuffle(_random)) {
      if (distractors.length >= optionCount - 1) break;
      // Nghe chọn chữ: loại cả từ đồng âm (他/她 đều là "tā") vì không thể
      // phân biệt bằng tai.
      if (type == ExerciseType.listenChoice && w.pinyin == answer.pinyin) continue;
      if (seen.add(keyOf(w))) distractors.add(w);
    }
    return [answer, ...distractors]..shuffle(_random);
  }
}
