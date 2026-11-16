import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_chinese/core/notifications/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  late tz.Location hcm;
  setUpAll(() {
    tzdata.initializeTimeZones();
    hcm = tz.getLocation('Asia/Ho_Chi_Minh');
  });

  test('giờ nhắc chưa tới → hôm nay', () {
    final now = tz.TZDateTime(hcm, 2026, 3, 10, 7, 30);
    final at = NotificationService.nextInstanceOf(const TimeOfDay(hour: 20, minute: 0), now);
    expect(at, tz.TZDateTime(hcm, 2026, 3, 10, 20, 0));
  });

  test('đã qua (hoặc đúng bằng) giờ nhắc → ngày mai', () {
    final now = tz.TZDateTime(hcm, 2026, 3, 10, 20, 0);
    final at = NotificationService.nextInstanceOf(const TimeOfDay(hour: 20, minute: 0), now);
    expect(at, tz.TZDateTime(hcm, 2026, 3, 11, 20, 0));
  });

  test('qua ranh giới tháng / năm', () {
    final now = tz.TZDateTime(hcm, 2026, 12, 31, 23, 0);
    final at = NotificationService.nextInstanceOf(const TimeOfDay(hour: 8, minute: 15), now);
    expect(at, tz.TZDateTime(hcm, 2027, 1, 1, 8, 15));
  });
}
