// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pronunciation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pinyinChart)
final pinyinChartProvider = PinyinChartProvider._();

final class PinyinChartProvider
    extends
        $FunctionalProvider<
          AsyncValue<PinyinChart>,
          PinyinChart,
          FutureOr<PinyinChart>
        >
    with $FutureModifier<PinyinChart>, $FutureProvider<PinyinChart> {
  PinyinChartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinyinChartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinyinChartHash();

  @$internal
  @override
  $FutureProviderElement<PinyinChart> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PinyinChart> create(Ref ref) {
    return pinyinChart(ref);
  }
}

String _$pinyinChartHash() => r'7076f58ad0371a4074a1e97ddea7be3c657403f3';

@ProviderFor(pronunciationDrills)
final pronunciationDrillsProvider = PronunciationDrillsProvider._();

final class PronunciationDrillsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PronunciationDrills>,
          PronunciationDrills,
          FutureOr<PronunciationDrills>
        >
    with
        $FutureModifier<PronunciationDrills>,
        $FutureProvider<PronunciationDrills> {
  PronunciationDrillsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pronunciationDrillsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pronunciationDrillsHash();

  @$internal
  @override
  $FutureProviderElement<PronunciationDrills> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PronunciationDrills> create(Ref ref) {
    return pronunciationDrills(ref);
  }
}

String _$pronunciationDrillsHash() =>
    r'49aafa7902ffa9c974401704a3857c11feebcd40';
