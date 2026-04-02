import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/features/settings/data/settings_repository.dart' as data;
import 'package:culcul/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return data.SettingsRepository(
    settingsStorageBox: ref.watch(settingsStorageBoxProvider),
  );
});
