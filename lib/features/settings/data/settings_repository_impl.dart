import 'dart:io';

import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/storage/storage_keys.dart';
import 'package:culcul/features/settings/models/app_theme_preference.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository_impl.g.dart';

@riverpod
SettingsRepositoryImpl settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(prefs: ref.watch(sharedPreferencesProvider));
}

class SettingsRepositoryImpl {
  const SettingsRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  AppThemePreference readThemePreference() {
    final storedValue = _prefs.getString(StorageKeys.themeMode);
    return AppThemePreference.fromStorage(storedValue);
  }

  Future<void> saveThemePreference(AppThemePreference preference) {
    return _prefs.setString(StorageKeys.themeMode, preference.storageValue);
  }

  Future<int> getCacheSizeInBytes() async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (!tempDir.existsSync()) return 0;
      return _calculateSize(tempDir);
    } catch (_) {
      return 0;
    }
  }

  Future<void> clearCache() async {
    final tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  }
}

Future<int> _calculateSize(FileSystemEntity file) async {
  if (file is File) {
    try {
      return await file.length();
    } catch (_) {
      return 0;
    }
  }

  if (file is Directory) {
    var sum = 0;
    try {
      await for (final child in file.list(followLinks: false)) {
        sum += await _calculateSize(child);
      }
    } catch (_) {}
    return sum;
  }

  return 0;
}
