// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.

@ProviderFor(ReviewSession)
final reviewSessionProvider = ReviewSessionFamily._();

/// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.
final class ReviewSessionProvider
    extends $AsyncNotifierProvider<ReviewSession, SessionState> {
  /// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.
  ReviewSessionProvider._({
    required ReviewSessionFamily super.from,
    required SessionMode super.argument,
  }) : super(
         retry: null,
         name: r'reviewSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reviewSessionHash();

  @override
  String toString() {
    return r'reviewSessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReviewSession create() => ReviewSession();

  @override
  bool operator ==(Object other) {
    return other is ReviewSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reviewSessionHash() => r'9017ae4140404757aaf42b8e395d9e54c3efeb03';

/// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.

final class ReviewSessionFamily extends $Family
    with
        $ClassFamilyOverride<
          ReviewSession,
          AsyncValue<SessionState>,
          SessionState,
          FutureOr<SessionState>,
          SessionMode
        > {
  ReviewSessionFamily._()
    : super(
        retry: null,
        name: r'reviewSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.

  ReviewSessionProvider call(SessionMode mode) =>
      ReviewSessionProvider._(argument: mode, from: this);

  @override
  String toString() => r'reviewSessionProvider';
}

/// Điều khiển một phiên ôn. autoDispose: mỗi lần mở màn là một phiên mới.

abstract class _$ReviewSession extends $AsyncNotifier<SessionState> {
  late final _$args = ref.$arg as SessionMode;
  SessionMode get mode => _$args;

  FutureOr<SessionState> build(SessionMode mode);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SessionState>, SessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SessionState>, SessionState>,
              AsyncValue<SessionState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
