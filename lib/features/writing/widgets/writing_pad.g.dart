// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing_pad.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(strokeData)
final strokeDataProvider = StrokeDataFamily._();

final class StrokeDataProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  StrokeDataProvider._({
    required StrokeDataFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'strokeDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$strokeDataHash();

  @override
  String toString() {
    return r'strokeDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as String;
    return strokeData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StrokeDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$strokeDataHash() => r'cd525c6402d24458f6173f14b07e1dfa8f4edd82';

final class StrokeDataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String?>, String> {
  StrokeDataFamily._()
    : super(
        retry: null,
        name: r'strokeDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StrokeDataProvider call(String char) =>
      StrokeDataProvider._(argument: char, from: this);

  @override
  String toString() => r'strokeDataProvider';
}
