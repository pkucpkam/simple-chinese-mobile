import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/lesson.dart';
import '../../data/models/word.dart';
import '../../data/providers.dart';

part 'path_providers.g.dart';

@riverpod
Stream<List<LessonNode>> lessonPath(Ref ref, int level) =>
    ref.watch(lessonRepositoryProvider).watchPath(level);

@riverpod
Future<LessonDetail> lessonDetail(Ref ref, String lessonId) =>
    ref.watch(lessonRepositoryProvider).detail(lessonId);

/// Nguồn đáp án nhiễu cho bài tập trong bài học: toàn bộ từ cùng cấp độ.
@riverpod
Future<List<Word>> levelWords(Ref ref, int level) =>
    ref.watch(wordRepositoryProvider).byLevel(level);
