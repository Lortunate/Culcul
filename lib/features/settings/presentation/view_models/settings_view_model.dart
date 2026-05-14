import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/settings/domain/entities/app_theme_preference.dart';
import 'package:culcul/features/settings/data/settings_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_view_model.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() =>
      ref.watch(settingsRepositoryProvider).readThemePreference().toThemeMode;

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await ref.read(settingsRepositoryProvider).saveThemePreference(mode.toPreference);
  }
}

@riverpod
Future<String> cacheSize(Ref ref) async {
  final totalSize = await ref.read(settingsRepositoryProvider).getCacheSizeInBytes();
  return totalSize.formatFileSize;
}

@riverpod
class CacheMaintenance extends _$CacheMaintenance {
  @override
  FutureOr<void> build() {}

  Future<void> clear() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(settingsRepositoryProvider).clearCache();
      ref.invalidate(cacheSizeProvider);
    });
  }
}

extension on AppThemePreference {
  ThemeMode get toThemeMode {
    return switch (this) {
      AppThemePreference.system => ThemeMode.system,
      AppThemePreference.light => ThemeMode.light,
      AppThemePreference.dark => ThemeMode.dark,
    };
  }
}

extension on ThemeMode {
  AppThemePreference get toPreference {
    return switch (this) {
      ThemeMode.system => AppThemePreference.system,
      ThemeMode.light => AppThemePreference.light,
      ThemeMode.dark => AppThemePreference.dark,
    };
  }
}
