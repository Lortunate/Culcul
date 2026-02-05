import 'package:culcul/data/models/app_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> getSettings();
  Future<void> saveSettings(AppSettingsModel settings);
  Future<void> clearSettings();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _settingsKey = 'app_settings';

  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<AppSettingsModel> getSettings() async {
    final jsonString = sharedPreferences.getString(_settingsKey);
    if (jsonString == null) {
      return _getDefaultSettings();
    }
    return AppSettingsModel.fromJson(
      Map<String, dynamic>.from(
        Uri.parse('data:application/json,$jsonString').path as Map,
      ),
    );
  }

  @override
  Future<void> saveSettings(AppSettingsModel settings) async {
    await sharedPreferences.setString(
      _settingsKey,
      settings.toJson().toString(),
    );
  }

  @override
  Future<void> clearSettings() async {
    await sharedPreferences.remove(_settingsKey);
  }

  AppSettingsModel _getDefaultSettings() {
    return AppSettingsModel(
      language: 'en',
      theme: 'light',
      notificationsEnabled: true,
      autoPlayEnabled: true,
      highQualityVideoEnabled: false,
      darkModeEnabled: false,
      showExplicitContent: true,
    );
  }
}
