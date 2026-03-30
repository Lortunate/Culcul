import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/data/user_info_cache_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_repository.g.dart';

@riverpod
class ProfileCacheRepository extends _$ProfileCacheRepository {
  @override
  Future<UserInfoCacheService> build() {
    return ref.watch(userInfoCacheServiceProvider.future);
  }

  Future<UserProfile?> read(String userId) async {
    final cache = await future;
    return cache.getUser(userId);
  }

  Future<void> write(UserProfile profile) async {
    final cache = await future;
    await cache.saveUser(profile);
  }
}
