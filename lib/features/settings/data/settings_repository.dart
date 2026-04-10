import 'package:culcul/features/settings/data/models/app_theme_preference.dart';

abstract class SettingsRepository {
  AppThemePreference readThemePreference();

  Future<void> saveThemePreference(AppThemePreference preference);

  Future<int> getCacheSizeInBytes();

  Future<void> clearCache();
}
