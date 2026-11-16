import 'package:flutter/material.dart';

import '../db/app_database.dart';

/// Cài đặt người dùng, lưu key-value trong bảng `settings`.
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  static const _themeMode = 'theme_mode';
  static const _dailyNewLimit = 'daily_new_limit';
  static const defaultDailyNewLimit = 10;

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
}
