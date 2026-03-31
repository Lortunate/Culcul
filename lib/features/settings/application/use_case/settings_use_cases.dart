import 'package:culcul/features/settings/domain/entities/app_theme_preference.dart';
import 'package:culcul/features/settings/domain/repositories/settings_repository.dart';
import 'package:culcul/features/settings/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsUseCasesProvider = Provider<SettingsUseCases>((ref) {
  return SettingsUseCases(ref.watch(settingsRepositoryProvider));
});

class SettingsUseCases {
  const SettingsUseCases(this._repository);

  final SettingsRepository _repository;

  AppThemePreference getThemePreference() => _repository.readThemePreference();

  Future<void> setThemePreference(AppThemePreference preference) {
    return _repository.saveThemePreference(preference);
  }

  Future<int> getCacheSizeInBytes() => _repository.getCacheSizeInBytes();

  Future<void> clearCache() => _repository.clearCache();
}
