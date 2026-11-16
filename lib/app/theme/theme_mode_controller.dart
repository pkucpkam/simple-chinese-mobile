import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers.dart';

part 'theme_mode_controller.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  Future<ThemeMode> build() => ref.watch(settingsRepositoryProvider).themeMode();

  Future<void> set(ThemeMode mode) async {
    state = AsyncData(mode);
    await ref.read(settingsRepositoryProvider).setThemeMode(mode);
  }
}
