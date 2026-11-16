import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/utils/text_search.dart';
import '../../data/models/word.dart';
import '../../data/providers.dart';

part 'word_providers.g.dart';

@riverpod
Stream<Word?> word(Ref ref, String id) =>
    ref.watch(wordRepositoryProvider).watchWord(id);

@riverpod
Stream<List<Word>> wordsByLevel(Ref ref, int level) =>
    ref.watch(wordRepositoryProvider).watchByLevel(level);

@Riverpod(keepAlive: true)
Stream<List<SearchEntry<Word>>> searchIndex(Ref ref) =>
    ref.watch(wordRepositoryProvider).watchSearchIndex();

/// Kết quả tra từ cho một truy vấn.
@riverpod
List<Word> searchResults(Ref ref, String query) {
  final index = ref.watch(searchIndexProvider).value ?? const [];
  return searchEntries(index, query);
}
