// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileStats)
final profileStatsProvider = ProfileStatsProvider._();

final class ProfileStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProfileStats>,
          ProfileStats,
          Stream<ProfileStats>
        >
    with $FutureModifier<ProfileStats>, $StreamProvider<ProfileStats> {
  ProfileStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileStatsHash();

  @$internal
  @override
  $StreamProviderElement<ProfileStats> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ProfileStats> create(Ref ref) {
    return profileStats(ref);
  }
}

String _$profileStatsHash() => r'510ba9f77818dd9cb9d84f210a827cc0a77b711f';

/// Cài đặt nhắc học. Khi khởi tạo, nếu đang bật thì hẹn lại lịch (phòng khi
/// app được cài lại / cập nhật làm mất lịch cũ).

@ProviderFor(ReminderController)
final reminderControllerProvider = ReminderControllerProvider._();

/// Cài đặt nhắc học. Khi khởi tạo, nếu đang bật thì hẹn lại lịch (phòng khi
/// app được cài lại / cập nhật làm mất lịch cũ).
final class ReminderControllerProvider
    extends $AsyncNotifierProvider<ReminderController, ReminderSettings> {
  /// Cài đặt nhắc học. Khi khởi tạo, nếu đang bật thì hẹn lại lịch (phòng khi
  /// app được cài lại / cập nhật làm mất lịch cũ).
  ReminderControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderControllerHash();

  @$internal
  @override
  ReminderController create() => ReminderController();
}

String _$reminderControllerHash() =>
    r'34e9a134ce58b846df31666defa3dd3707b58eef';

/// Cài đặt nhắc học. Khi khởi tạo, nếu đang bật thì hẹn lại lịch (phòng khi
/// app được cài lại / cập nhật làm mất lịch cũ).

abstract class _$ReminderController extends $AsyncNotifier<ReminderSettings> {
  FutureOr<ReminderSettings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ReminderSettings>, ReminderSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReminderSettings>, ReminderSettings>,
              AsyncValue<ReminderSettings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Đã qua màn giới thiệu chưa.

@ProviderFor(OnboardingDone)
final onboardingDoneProvider = OnboardingDoneProvider._();

/// Đã qua màn giới thiệu chưa.
final class OnboardingDoneProvider
    extends $AsyncNotifierProvider<OnboardingDone, bool> {
  /// Đã qua màn giới thiệu chưa.
  OnboardingDoneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingDoneProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingDoneHash();

  @$internal
  @override
  OnboardingDone create() => OnboardingDone();
}

String _$onboardingDoneHash() => r'b076bc28c84754eec2468df88fdfcb100f736643';

/// Đã qua màn giới thiệu chưa.

abstract class _$OnboardingDone extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
