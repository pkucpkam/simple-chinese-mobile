import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/lesson.dart';
import '../../data/models/word.dart';
import '../../data/providers.dart';

part 'path_providers.g.dart';

@riverpod
Stream<List<LessonSummary>> lessons(Ref ref, int level) =>
    ref.watch(lessonRepositoryProvider).watchLessons(level);

@riverpod
Future<List<Word>> lessonWords(Ref ref, String lessonId) =>
    ref.watch(wordRepositoryProvider).byLesson(lessonId);
