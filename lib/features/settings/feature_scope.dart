import 'package:culcul/shared/providers/storage_provider.dart';
import 'package:culcul/features/settings/data/settings_repository.dart';
import 'package:culcul/features/settings/data/settings_repository_impl.dart' as data;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return data.SettingsRepositoryImpl(
    settingsStorageBox: ref.watch(settingsStorageBoxProvider),
  );
});
