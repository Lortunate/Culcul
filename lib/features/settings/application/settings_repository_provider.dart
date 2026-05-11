import 'package:culcul/features/settings/data/settings_repository_impl.dart' as data;
import 'package:culcul/features/settings/domain/repositories/settings_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsRepositoryProvider = data.settingsRepositoryProvider;

final settingsRepositoryEntryProvider = Provider<SettingsRepository>((ref) {
  return ref.watch(settingsRepositoryProvider);
});
