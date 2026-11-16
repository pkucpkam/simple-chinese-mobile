import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../app/strings.dart';

part 'notification_service.g.dart';

/// Nhắc học hằng ngày bằng thông báo cục bộ (không cần mạng / server).
class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static const _dailyId = 1;
  static const _channel = AndroidNotificationDetails(
    'daily_reminder',
    S.reminderChannelName,
    channelDescription: S.reminderChannelDescription,
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );

  Future<void> _init() async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final local = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(local.identifier));
    } catch (e) {
      // Không lấy được múi giờ → giữ UTC; thông báo có thể lệch giờ nhưng
      // app vẫn chạy bình thường.
      debugPrint('Không xác định được múi giờ: $e');
    }
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _ready = true;
  }

  /// Xin quyền hiện thông báo (Android 13+ / iOS). Trả về true nếu được cấp.
  Future<bool> requestPermission() async {
    await _init();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) return await android.requestNotificationsPermission() ?? false;
    final ios = _plugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }
    return true;
  }

  /// Hẹn thông báo lặp lại mỗi ngày vào [time] (thay lịch cũ nếu có).
  Future<void> scheduleDaily(TimeOfDay time) async {
    await _init();
    await _plugin.cancel(id: _dailyId);
    await _plugin.zonedSchedule(
      id: _dailyId,
      title: S.reminderTitle,
      body: S.reminderBody,
      scheduledDate: nextInstanceOf(time, tz.TZDateTime.now(tz.local)),
      notificationDetails: const NotificationDetails(
        android: _channel,
        iOS: DarwinNotificationDetails(),
      ),
      // Không cần quyền "báo thức chính xác": lệch vài phút không sao.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDaily() async {
    await _init();
    await _plugin.cancel(id: _dailyId);
  }

  /// Thời điểm [time] gần nhất kể từ [now] (hôm nay nếu chưa qua, không thì
  /// ngày mai).
  @visibleForTesting
  static tz.TZDateTime nextInstanceOf(TimeOfDay time, tz.TZDateTime now) {
    var at = tz.TZDateTime(now.location, now.year, now.month, now.day, time.hour, time.minute);
    if (!at.isAfter(now)) {
      at = tz.TZDateTime(now.location, now.year, now.month, now.day + 1, time.hour, time.minute);
    }
    return at;
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => NotificationService();
