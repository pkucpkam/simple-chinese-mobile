import 'dart:math';

import '../../core/pinyin/pinyin.dart';
import '../../data/models/lesson.dart';
import '../../data/models/srs_card.dart';
import '../../data/models/word.dart';
import '../../data/srs/exercise_selector.dart';
import '../review/session/session_builder.dart';
import '../review/session/session_task.dart';

/// Một bước bài tập trong phần Luyện tập / Kiểm tra của bài học.
sealed class LessonStep {
  const LessonStep();
}

/// Bài tập dùng chung với phiên ôn (trắc nghiệm, nghe, thanh, gõ pinyin).
final class TaskStep extends LessonStep {
  const TaskStep(this.task);
  final SessionTask task;
}

final class SentenceStep extends LessonStep {
  const SentenceStep(this.sentence);
  final OrderSentence sentence;
}

/// Viết chữ. [guided] = bắt đầu ở chế độ tập tô (dùng cho phần Luyện tập).
final class WriteStep extends LessonStep {
  const WriteStep(this.item, {this.guided = false});
  final StudyItem item;
  final bool guided;
}

/// Dựng phần Luyện tập và Kiểm tra cho một bài. Hàm thuần — truyền [random]
/// cố định để test.
class LessonPlanner {
  LessonPlanner({Random? random}) : _r = random ?? Random();

  final Random _r;
  late final SessionBuilder _builder = SessionBuilder(random: _r);

  /// Số câu của bài kiểm tra.
  static const quizLength = 10;

  /// Luyện tập (không chấm điểm): mỗi từ một câu trắc nghiệm (xen kẽ nhìn
  /// chữ chọn nghĩa / nghe chọn chữ), 1 câu sắp xếp, 1 bài tô chữ.
  List<LessonStep> practice(LessonDetail d, {required List<Word> pool}) {
    final steps = <LessonStep>[
      for (final (i, w) in d.words.indexed)
        TaskStep(_choice(
          i.isEven ? ExerciseType.meaningChoice : ExerciseType.listenChoice,
          w,
          pool,
        )),
    ];
    if (d.sentences.isNotEmpty) steps.add(SentenceStep(d.sentences.first));
    final writable = d.words.where((w) => w.mustWrite).toList();
    if (writable.isNotEmpty) {
      steps.add(WriteStep(_item(writable[_r.nextInt(writable.length)], CardSkill.write),
          guided: true));
    }
    return steps;
  }

  /// Kiểm tra: [quizLength] câu trộn dạng: 4 nghĩa, 2 nghe, 2 thanh,
  /// 1 gõ pinyin, 1 sắp xếp câu. Từ được xoay vòng nếu bài ít từ.
  List<LessonStep> quiz(LessonDetail d, {required List<Word> pool}) {
    final words = List.of(d.words)..shuffle(_r);
    if (words.isEmpty) return const [];
    Word at(int i) => words[i % words.length];

    final types = [
      ExerciseType.meaningChoice,
      ExerciseType.meaningChoice,
      ExerciseType.meaningChoice,
      ExerciseType.meaningChoice,
      ExerciseType.listenChoice,
      ExerciseType.listenChoice,
      ExerciseType.toneChoice,
      ExerciseType.toneChoice,
      ExerciseType.typePinyin,
    ];
    final steps = <LessonStep>[
      for (final (i, t) in types.indexed) TaskStep(_task(t, at(i), pool)),
    ];
    final sentence = d.sentences.length > 1 ? d.sentences[1] : d.sentences.firstOrNull;
    steps.add(sentence != null
        ? SentenceStep(sentence)
        : TaskStep(_task(ExerciseType.meaningChoice, at(types.length), pool)));
    steps.shuffle(_r);
    return steps;
  }

  SessionTask _task(ExerciseType t, Word w, List<Word> pool) => switch (t) {
        ExerciseType.toneChoice => ToneChoiceTask(
            _item(w, CardSkill.tone), toneVariants(w.pinyin, _r.nextInt)),
        ExerciseType.typePinyin => TypePinyinTask(_item(w, CardSkill.read)),
        _ => _choice(t, w, pool),
      };

  ChoiceTask _choice(ExerciseType t, Word w, List<Word> pool) => ChoiceTask(
        t,
        _item(w, t == ExerciseType.listenChoice ? CardSkill.listen : CardSkill.read),
        _builder.options(w, pool, t),
      );

  /// Bài học không chấm vào SRS, nên dùng thẻ "ảo" (id âm) để tái sử dụng
  /// các widget bài tập của phiên ôn.
  int _fakeId = 0;
  StudyItem _item(Word w, CardSkill skill) => StudyItem(
        card: SrsCard(id: --_fakeId, wordId: w.id, skill: skill, due: DateTime(2000)),
        word: w,
      );
}

/// Điểm quiz (0–100) từ số câu đúng.
int quizScore(int correct, int total) =>
    total == 0 ? 0 : (100 * correct / total).round();
