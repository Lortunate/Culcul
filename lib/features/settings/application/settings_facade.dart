import 'package:culcul/features/settings/domain/repositories/settings_repository.dart';
import 'package:culcul/features/settings/data/settings_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_facade.g.dart';

@riverpod
SettingsFacade settingsFacade(Ref ref) {
  return SettingsFacade(ref.watch(settingsRepositoryProvider));
}

class SettingsFacade {
  SettingsFacade(this.repository);

  final SettingsRepository repository;
}
