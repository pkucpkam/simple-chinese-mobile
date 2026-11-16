import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/srs_card.dart';
import '../../../data/models/word.dart';
import '../../../data/providers.dart';
import '../../../data/repositories/srs_repository.dart';
import '../../../data/srs/srs_scheduler.dart';
import 'session_builder.dart';
import 'session_task.dart';

part 'review_session_controller.freezed.dart';
part 'review_session_controller.g.dart';

@freezed
abstract class SessionState with _$SessionState {
  const SessionState._();

  const factory SessionState({
    required SessionMode mode,
    required List<SessionTask> tasks,
    required DateTime startedAt,
    @Default(0) int index,
    @Default(0) int answered,
    @Default(0) int correct,
    @Default(0) int xp,

    /// Số lần đã cho làm lại theo cardId (giới hạn để phiên không kéo dài).
    @Default(<int, int>{}) Map<int, int> retries,
  }) = _SessionState;

  bool get isEmpty => tasks.isEmpty;
  bool get finished => index >= tasks.length;
  SessionTask? get current => finished ? null : tasks[index];
  double get progress => tasks.isEmpty ? 0 : index / tasks.length;
  double get accuracy => answered == 0 ? 0 : correct / answered;
}

/// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.
@riverpod
class ReviewSession extends _$ReviewSession {
  static const maxRetriesPerCard = 2;

  final _builder = SessionBuilder();
  List<Word> _pool = const [];

  SrsRepository get _repo => ref.read(srsRepositoryProvider);

  @override
  Future<SessionState> build(SessionMode mode) async {
    final queue = await _repo.buildQueue();
    // Nguồn đáp án nhiễu: toàn bộ từ của các cấp độ có trong phiên.
    final words = ref.read(wordRepositoryProvider);
    final levels = queue.map((i) => i.word.level).toSet();
    _pool = [for (final l in levels) ...await words.byLevel(l)];
    return SessionState(
      mode: mode,
      tasks: _builder.build(queue, mode: mode, pool: _pool),
      startedAt: DateTime.now(),
    );
  }

  /// Chấm một thẻ. Với ghép cặp, gọi nhiều lần trong cùng một bước.
  /// Thẻ bị Again sẽ được thêm lại vào cuối phiên (tối đa [maxRetriesPerCard]).
  Future<void> grade(StudyItem item, Rating rating, Duration elapsed) async {
    final updated = await _repo.recordReview(
      cardId: item.card.id,
      rating: rating,
      durationMs: elapsed.inMilliseconds,
    );
    final s = state.requireValue;
    var tasks = s.tasks;
    var retries = s.retries;
    final used = retries[item.card.id] ?? 0;
    if (rating == Rating.again && used < maxRetriesPerCard) {
      final again = item.copyWith(card: updated);
      tasks = [
        ...tasks,
        s.mode == SessionMode.flashcard
            ? FlashcardTask(again)
            : _builder.retry(again, _pool),
      ];
      retries = {...retries, item.card.id: used + 1};
    }
    state = AsyncData(s.copyWith(
      tasks: tasks,
      retries: retries,
      answered: s.answered + 1,
      correct: s.correct + (rating == Rating.again ? 0 : 1),
      xp: s.xp + SrsRepository.xpFor(rating),
    ));
  }

  /// Sang bài tiếp theo. Khi hết phiên thì ghi số phút học.
  Future<void> next() async {
    final s = state.requireValue;
    final nextState = s.copyWith(index: s.index + 1);
    state = AsyncData(nextState);
    if (nextState.finished) {
      final minutes =
          (DateTime.now().difference(s.startedAt).inSeconds / 60).ceil();
      await _repo.addStudyMinutes(minutes);
    }
  }
}
