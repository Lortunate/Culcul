import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_actions.g.dart';

@riverpod
ProfileCacheActions profileCacheActions(Ref ref) {
  return ProfileCacheActions(ref.watch(profileCacheRepositoryProvider));
}

class ProfileCacheActions {
  const ProfileCacheActions(this._cache);

  final ProfileCacheRepositoryImpl _cache;

  Future<void> clearAll() {
    return _cache.clearAll();
  }
}
