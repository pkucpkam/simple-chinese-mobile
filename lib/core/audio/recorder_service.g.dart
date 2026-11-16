// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recorder_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recorderService)
final recorderServiceProvider = RecorderServiceProvider._();

final class RecorderServiceProvider
    extends
        $FunctionalProvider<RecorderService, RecorderService, RecorderService>
    with $Provider<RecorderService> {
  RecorderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recorderServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recorderServiceHash();

  @$internal
  @override
  $ProviderElement<RecorderService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecorderService create(Ref ref) {
    return recorderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecorderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecorderService>(value),
    );
  }
}

String _$recorderServiceHash() => r'53be291f68248f5fa0813a0cb2c2a3bec46b7fe9';
