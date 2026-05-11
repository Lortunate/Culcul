import 'package:culcul/features/settings/domain/repositories/settings_repository.dart';
import 'package:culcul/features/settings/application/settings_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_facade.g.dart';

@riverpod
SettingsFacade settingsFacade(Ref ref) {
  return SettingsFacade(ref.watch(settingsRepositoryEntryProvider));
}

class SettingsFacade {
  SettingsFacade(SettingsRepository repository) : _repository = repository;

  // ignore: unused_field
  final SettingsRepository _repository;
}
