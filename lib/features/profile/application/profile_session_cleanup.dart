import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:culcul/features/profile/application/profile_cache_application_providers.dart';
import 'package:culcul/features/profile/application/profile_cache_port.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

SessionLogoutCleaner createProfileSessionLogoutCleaner(Ref ref) {
  return ProfileSessionLogoutCleaner(ref.watch(profileCachePortProvider));
}

final class ProfileSessionLogoutCleaner implements SessionLogoutCleaner {
  const ProfileSessionLogoutCleaner(this._cache);

  final ProfileCachePort _cache;

  @override
  Future<void> clearAfterLogout() {
    return _cache.clearAll();
  }
}
