import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../db/app_database.dart';

/// Cài đặt người dùng, lưu key-value trong bảng `settings`.
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  static const _themeMode = 'theme_mode';
  static const _dailyNewLimit = 'daily_new_limit';
  static const defaultDailyNewLimit = 10;
  static const _reminderEnabled = 'reminder_enabled';
  static const _reminderTime = 'reminder_time';
  static const _onboardingDone = 'onboarding_done';
  static const defaultReminder = TimeOfDay(hour: 20, minute: 0);

  Future<String?> _get(String key) async {
    final row = await (_db.select(_db.settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> _set(String key, String value) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));

  Future<ThemeMode> themeMode() async {
    final v = await _get(_themeMode);
    return ThemeMode.values.firstWhere(
      (m) => m.name == v,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) => _set(_themeMode, mode.name);

  Future<int> dailyNewLimit() async =>
      int.tryParse(await _get(_dailyNewLimit) ?? '') ?? defaultDailyNewLimit;

  Future<void> setDailyNewLimit(int value) =>
      _set(_dailyNewLimit, value.toString());

  Future<bool> reminderEnabled() async => await _get(_reminderEnabled) == 'true';

  Future<void> setReminderEnabled(bool v) => _set(_reminderEnabled, '$v');

  /// Giờ nhắc học, lưu dạng "HH:mm".
  Future<TimeOfDay> reminderTime() async {
    final m = RegExp(r'^(\d{1,2}):(\d{2})$').firstMatch(await _get(_reminderTime) ?? '');
    if (m == null) return defaultReminder;
    return TimeOfDay(hour: int.parse(m.group(1)!), minute: int.parse(m.group(2)!));
  }

  Future<void> setReminderTime(TimeOfDay t) => _set(
      _reminderTime,
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}');

  /// Đã qua màn giới thiệu chưa. Người dùng cũ (đã có thẻ) coi như đã xong.
  Future<bool> onboardingDone() async {
    if (await _get(_onboardingDone) == 'true') return true;
    final cards = await _db.cards.count().getSingle();
    return cards > 0;
  }

  Future<void> setOnboardingDone() => _set(_onboardingDone, 'true');
}
