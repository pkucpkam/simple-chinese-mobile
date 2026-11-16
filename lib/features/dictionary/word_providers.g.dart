// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(word)
final wordProvider = WordFamily._();

final class WordProvider
    extends $FunctionalProvider<AsyncValue<Word?>, Word?, Stream<Word?>>
    with $FutureModifier<Word?>, $StreamProvider<Word?> {
  WordProvider._({
    required WordFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'wordProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wordHash();

  @override
  String toString() {
    return r'wordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Word?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Word?> create(Ref ref) {
    final argument = this.argument as String;
    return word(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordHash() => r'294d0bb80020481f6de20232448505345adad2ca';

final class WordFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Word?>, String> {
  WordFamily._()
    : super(
        retry: null,
        name: r'wordProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WordProvider call(String id) => WordProvider._(argument: id, from: this);

  @override
  String toString() => r'wordProvider';
}

@ProviderFor(wordsByLevel)
final wordsByLevelProvider = WordsByLevelFamily._();

final class WordsByLevelProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Word>>,
          List<Word>,
          Stream<List<Word>>
        >
    with $FutureModifier<List<Word>>, $StreamProvider<List<Word>> {
  WordsByLevelProvider._({
    required WordsByLevelFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'wordsByLevelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wordsByLevelHash();

  @override
  String toString() {
    return r'wordsByLevelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Word>> create(Ref ref) {
    final argument = this.argument as int;
    return wordsByLevel(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WordsByLevelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wordsByLevelHash() => r'873fb0c69a9eea40973dc795c13c0e1d1adfe382';

final class WordsByLevelFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Word>>, int> {
  WordsByLevelFamily._()
    : super(
        retry: null,
        name: r'wordsByLevelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WordsByLevelProvider call(int level) =>
      WordsByLevelProvider._(argument: level, from: this);

  @override
  String toString() => r'wordsByLevelProvider';
}

@ProviderFor(searchIndex)
final searchIndexProvider = SearchIndexProvider._();

final class SearchIndexProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SearchEntry<Word>>>,
          List<SearchEntry<Word>>,
          Stream<List<SearchEntry<Word>>>
        >
    with
        $FutureModifier<List<SearchEntry<Word>>>,
        $StreamProvider<List<SearchEntry<Word>>> {
  SearchIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchIndexHash();

  @$internal
  @override
  $StreamProviderElement<List<SearchEntry<Word>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SearchEntry<Word>>> create(Ref ref) {
    return searchIndex(ref);
  }
}

String _$searchIndexHash() => r'c64395528ba1253bf7ce88bb10219a8726e4cef7';

/// Kết quả tra từ cho một truy vấn.

@ProviderFor(searchResults)
final searchResultsProvider = SearchResultsFamily._();

/// Kết quả tra từ cho một truy vấn.

final class SearchResultsProvider
    extends $FunctionalProvider<List<Word>, List<Word>, List<Word>>
    with $Provider<List<Word>> {
  /// Kết quả tra từ cho một truy vấn.
  SearchResultsProvider._({
    required SearchResultsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchResultsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchResultsHash();

  @override
  String toString() {
    return r'searchResultsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Word> create(Ref ref) {
    final argument = this.argument as String;
    return searchResults(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Word> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Word>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SearchResultsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchResultsHash() => r'c797f3fbb5ff9df28e61796ea0da5a288ff5e8f3';

/// Kết quả tra từ cho một truy vấn.

final class SearchResultsFamily extends $Family
    with $FunctionalFamilyOverride<List<Word>, String> {
  SearchResultsFamily._()
    : super(
        retry: null,
        name: r'searchResultsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Kết quả tra từ cho một truy vấn.

  SearchResultsProvider call(String query) =>
      SearchResultsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchResultsProvider';
}
