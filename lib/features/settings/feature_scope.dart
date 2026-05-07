import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/features/settings/domain/repositories/settings_repository.dart';
import 'package:culcul/features/settings/data/settings_repository_impl.dart' as data;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return data.SettingsRepositoryImpl(
    settingsStorageBox: ref.watch(settingsStorageBoxProvider),
  );
});
