// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lessons)
final lessonsProvider = LessonsFamily._();

final class LessonsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LessonSummary>>,
          List<LessonSummary>,
          Stream<List<LessonSummary>>
        >
    with
        $FutureModifier<List<LessonSummary>>,
        $StreamProvider<List<LessonSummary>> {
  LessonsProvider._({
    required LessonsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'lessonsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lessonsHash();

  @override
  String toString() {
    return r'lessonsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<LessonSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LessonSummary>> create(Ref ref) {
    final argument = this.argument as int;
    return lessons(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonsHash() => r'cba38e6efc9910d63de82c32b668b5153d40629c';

final class LessonsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<LessonSummary>>, int> {
  LessonsFamily._()
    : super(
        retry: null,
        name: r'lessonsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LessonsProvider call(int level) =>
      LessonsProvider._(argument: level, from: this);

  @override
  String toString() => r'lessonsProvider';
}

@ProviderFor(lessonWords)
final lessonWordsProvider = LessonWordsFamily._();

final class LessonWordsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Word>>,
          List<Word>,
          FutureOr<List<Word>>
        >
    with $FutureModifier<List<Word>>, $FutureProvider<List<Word>> {
  LessonWordsProvider._({
    required LessonWordsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'lessonWordsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lessonWordsHash();

  @override
  String toString() {
    return r'lessonWordsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Word>> create(Ref ref) {
    final argument = this.argument as String;
    return lessonWords(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonWordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonWordsHash() => r'fa678cfb5f677721c3003be6a244a60a313b7586';

final class LessonWordsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Word>>, String> {
  LessonWordsFamily._()
    : super(
        retry: null,
        name: r'lessonWordsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LessonWordsProvider call(String lessonId) =>
      LessonWordsProvider._(argument: lessonId, from: this);

  @override
  String toString() => r'lessonWordsProvider';
}
