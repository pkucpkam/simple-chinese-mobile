import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/word.dart';
import '../../data/providers.dart';

part 'word_providers.g.dart';

@riverpod
Stream<Word?> word(Ref ref, String id) =>
    ref.watch(wordRepositoryProvider).watchWord(id);

@riverpod
Stream<List<Word>> wordsByLevel(Ref ref, int level) =>
    ref.watch(wordRepositoryProvider).watchByLevel(level);
