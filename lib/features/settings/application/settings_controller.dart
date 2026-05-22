import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/settings/data/settings_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
Future<String> cacheSize(Ref ref) async {
  final totalSize = await ref.read(settingsRepositoryProvider).getCacheSizeInBytes();
  return totalSize.formatFileSize;
}

@riverpod
class CacheMaintenance extends _$CacheMaintenance {
  @override
  FutureOr<void> build() {}

  Future<void> clear() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(settingsRepositoryProvider).clearCache();
      ref.invalidate(cacheSizeProvider);
    });
  }
}
