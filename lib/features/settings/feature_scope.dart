import 'package:culcul/features/settings/application/settings_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/settings/application/settings_facade.dart' show settingsFacadeProvider;
export 'package:culcul/features/settings/application/settings_repository_provider.dart'
    show settingsRepositoryProvider;

final settingsFacadeEntryProvider = Provider<SettingsFacade>(
  (ref) => ref.watch(settingsFacadeProvider),
);
