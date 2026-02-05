import 'package:culcul/data/api/settings_local_datasource.dart';
import 'package:culcul/data/models/app_settings_model.dart';
import 'package:culcul/domain/entities/app_settings.dart';

class SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepository(this.localDataSource);

  Future<AppSettings> getSettings() async {
    final model = await localDataSource.getSettings();
    return model.toEntity();
  }

  Future<void> updateSettings(AppSettings settings) async {
    final model = AppSettingsModel.fromEntity(settings);
    await localDataSource.saveSettings(model);
  }

  Future<void> resetToDefaults() async {
    await localDataSource.clearSettings();
  }
}
