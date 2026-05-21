import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

SessionLogoutCleaner createProfileSessionLogoutCleaner(Ref ref) {
  return ProfileSessionLogoutCleaner(ref.watch(profileCacheRepositoryProvider));
}

final class ProfileSessionLogoutCleaner implements SessionLogoutCleaner {
  const ProfileSessionLogoutCleaner(this._cache);

  final ProfileCacheRepositoryImpl _cache;

  @override
  Future<void> clearAfterLogout() {
    return _cache.clearAll();
  }
}
