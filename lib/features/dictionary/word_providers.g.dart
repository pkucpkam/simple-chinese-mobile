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
