import 'package:culcul/features/profile/data/user_info_cache_repository.dart';
import 'package:culcul/features/profile/data/dtos/profile_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_repository.g.dart';

@riverpod
ProfileCacheRepositoryImpl profileCacheRepository(Ref ref) {
  return ProfileCacheRepositoryImpl(ref.watch(userInfoCacheRepositoryProvider));
}

class ProfileCacheRepositoryImpl {
  final UserInfoCacheRepository _cache;

  ProfileCacheRepositoryImpl(this._cache);

  Future<ProfileUser?> readProfile(String userId) async {
    return await _cache.getUser(userId);
  }

  Future<void> writeProfile(ProfileUser profile) async {
    await _cache.saveUser(profile);
  }

  Future<void> clearProfile(String userId) async {
    await _cache.removeUser(userId);
  }

  Future<void> clearAll() async {
    await _cache.clearAllUsers();
  }
}
