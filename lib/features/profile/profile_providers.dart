import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/notifications/notification_service.dart';
import '../../data/models/profile_stats.dart';
import '../../data/providers.dart';

part 'profile_providers.g.dart';

@riverpod
Stream<ProfileStats> profileStats(Ref ref) =>
    ref.watch(statsRepositoryProvider).watchProfile();

class ReminderSettings {
  const ReminderSettings({required this.enabled, required this.time});
  final bool enabled;
  final TimeOfDay time;
}

/// Cài đặt nhắc học. Khi khởi tạo, nếu đang bật thì hẹn lại lịch (phòng khi
/// app được cài lại / cập nhật làm mất lịch cũ).
@Riverpod(keepAlive: true)
class ReminderController extends _$ReminderController {
  @override
  Future<ReminderSettings> build() async {
    final settings = ref.watch(settingsRepositoryProvider);
    final r = ReminderSettings(
      enabled: await settings.reminderEnabled(),
      time: await settings.reminderTime(),
    );
    if (r.enabled) {
      await ref.read(notificationServiceProvider).scheduleDaily(r.time).catchError(
            (Object e) => debugPrint('Không hẹn được nhắc học: $e'),
          );
    }
    return r;
  }

  /// Bật/tắt. Trả về false nếu người dùng không cấp quyền thông báo.
  Future<bool> setEnabled(bool enabled) async {
    final notif = ref.read(notificationServiceProvider);
    final settings = ref.read(settingsRepositoryProvider);
    final time = state.value?.time ?? await settings.reminderTime();
    if (enabled) {
      if (!await notif.requestPermission()) return false;
      await notif.scheduleDaily(time);
    } else {
      await notif.cancelDaily();
    }
    await settings.setReminderEnabled(enabled);
    state = AsyncData(ReminderSettings(enabled: enabled, time: time));
    return true;
  }

  Future<void> setTime(TimeOfDay time) async {
    final settings = ref.read(settingsRepositoryProvider);
    await settings.setReminderTime(time);
    final enabled = state.value?.enabled ?? false;
    if (enabled) await ref.read(notificationServiceProvider).scheduleDaily(time);
    state = AsyncData(ReminderSettings(enabled: enabled, time: time));
  }
}

/// Đã qua màn giới thiệu chưa.
@Riverpod(keepAlive: true)
class OnboardingDone extends _$OnboardingDone {
  @override
  Future<bool> build() => ref.watch(settingsRepositoryProvider).onboardingDone();

  Future<void> complete() async {
    await ref.read(settingsRepositoryProvider).setOnboardingDone();
    state = const AsyncData(true);
  }
}
