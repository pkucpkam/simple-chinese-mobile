// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deckStats)
final deckStatsProvider = DeckStatsProvider._();

final class DeckStatsProvider
    extends
        $FunctionalProvider<AsyncValue<DeckStats>, DeckStats, Stream<DeckStats>>
    with $FutureModifier<DeckStats>, $StreamProvider<DeckStats> {
  DeckStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckStatsHash();

  @$internal
  @override
  $StreamProviderElement<DeckStats> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DeckStats> create(Ref ref) {
    return deckStats(ref);
  }
}

String _$deckStatsHash() => r'15490c23506a65721d4db52edd6af8dbf75eb31e';

@ProviderFor(inDeck)
final inDeckProvider = InDeckFamily._();

final class InDeckProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  InDeckProvider._({
    required InDeckFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'inDeckProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inDeckHash();

  @override
  String toString() {
    return r'inDeckProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as String;
    return inDeck(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InDeckProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inDeckHash() => r'36e64a11afad36f2f08759285aa43fa53b739b04';

final class InDeckFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, String> {
  InDeckFamily._()
    : super(
        retry: null,
        name: r'inDeckProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InDeckProvider call(String wordId) =>
      InDeckProvider._(argument: wordId, from: this);

  @override
  String toString() => r'inDeckProvider';
}

/// Số thẻ mới tối đa mỗi ngày (chỉnh trong tab Tôi).

@ProviderFor(DailyNewLimit)
final dailyNewLimitProvider = DailyNewLimitProvider._();

/// Số thẻ mới tối đa mỗi ngày (chỉnh trong tab Tôi).
final class DailyNewLimitProvider
    extends $AsyncNotifierProvider<DailyNewLimit, int> {
  /// Số thẻ mới tối đa mỗi ngày (chỉnh trong tab Tôi).
  DailyNewLimitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyNewLimitProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyNewLimitHash();

  @$internal
  @override
  DailyNewLimit create() => DailyNewLimit();
}

String _$dailyNewLimitHash() => r'505c6f8293e928c86196437016f5f66be154200a';

/// Số thẻ mới tối đa mỗi ngày (chỉnh trong tab Tôi).

abstract class _$DailyNewLimit extends $AsyncNotifier<int> {
  FutureOr<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
