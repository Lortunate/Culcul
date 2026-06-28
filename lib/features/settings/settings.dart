import 'package:culcul/features/settings/data/settings_repository_impl.dart';
import 'package:culcul/features/settings/models/app_theme_preference.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    return switch (ref.watch(settingsRepositoryProvider).readThemePreference()) {
      AppThemePreference.system => ThemeMode.system,
      AppThemePreference.light => ThemeMode.light,
      AppThemePreference.dark => ThemeMode.dark,
    };
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final preference = switch (mode) {
      ThemeMode.system => AppThemePreference.system,
      ThemeMode.light => AppThemePreference.light,
      ThemeMode.dark => AppThemePreference.dark,
    };
    await ref.read(settingsRepositoryProvider).saveThemePreference(preference);
  }
}
