// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lessonPath)
final lessonPathProvider = LessonPathFamily._();

final class LessonPathProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LessonNode>>,
          List<LessonNode>,
          Stream<List<LessonNode>>
        >
    with $FutureModifier<List<LessonNode>>, $StreamProvider<List<LessonNode>> {
  LessonPathProvider._({
    required LessonPathFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'lessonPathProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lessonPathHash();

  @override
  String toString() {
    return r'lessonPathProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<LessonNode>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LessonNode>> create(Ref ref) {
    final argument = this.argument as int;
    return lessonPath(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonPathProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonPathHash() => r'f690c82ca1643c708fb34fda41cadd45064f72bb';

final class LessonPathFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<LessonNode>>, int> {
  LessonPathFamily._()
    : super(
        retry: null,
        name: r'lessonPathProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LessonPathProvider call(int level) =>
      LessonPathProvider._(argument: level, from: this);

  @override
  String toString() => r'lessonPathProvider';
}

@ProviderFor(lessonDetail)
final lessonDetailProvider = LessonDetailFamily._();

final class LessonDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<LessonDetail>,
          LessonDetail,
          FutureOr<LessonDetail>
        >
    with $FutureModifier<LessonDetail>, $FutureProvider<LessonDetail> {
  LessonDetailProvider._({
    required LessonDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'lessonDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lessonDetailHash();

  @override
  String toString() {
    return r'lessonDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LessonDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LessonDetail> create(Ref ref) {
    final argument = this.argument as String;
    return lessonDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lessonDetailHash() => r'38697fb4f25d0b215cb6a4941c79331ccc5ea49e';

final class LessonDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LessonDetail>, String> {
  LessonDetailFamily._()
    : super(
        retry: null,
        name: r'lessonDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LessonDetailProvider call(String lessonId) =>
      LessonDetailProvider._(argument: lessonId, from: this);

  @override
  String toString() => r'lessonDetailProvider';
}

/// Nguồn đáp án nhiễu cho bài tập trong bài học: toàn bộ từ cùng cấp độ.

@ProviderFor(levelWords)
final levelWordsProvider = LevelWordsFamily._();

/// Nguồn đáp án nhiễu cho bài tập trong bài học: toàn bộ từ cùng cấp độ.

final class LevelWordsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Word>>,
          List<Word>,
          FutureOr<List<Word>>
        >
    with $FutureModifier<List<Word>>, $FutureProvider<List<Word>> {
  /// Nguồn đáp án nhiễu cho bài tập trong bài học: toàn bộ từ cùng cấp độ.
  LevelWordsProvider._({
    required LevelWordsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'levelWordsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$levelWordsHash();

  @override
  String toString() {
    return r'levelWordsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Word>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Word>> create(Ref ref) {
    final argument = this.argument as int;
    return levelWords(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LevelWordsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$levelWordsHash() => r'94960dd1ef332945fd7938eb56ef95a1dd81b3c2';

/// Nguồn đáp án nhiễu cho bài tập trong bài học: toàn bộ từ cùng cấp độ.

final class LevelWordsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Word>>, int> {
  LevelWordsFamily._()
    : super(
        retry: null,
        name: r'levelWordsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Nguồn đáp án nhiễu cho bài tập trong bài học: toàn bộ từ cùng cấp độ.

  LevelWordsProvider call(int level) =>
      LevelWordsProvider._(argument: level, from: this);

  @override
  String toString() => r'levelWordsProvider';
}
