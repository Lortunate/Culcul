import 'package:culcul/features/profile/data/dtos/profile_user.dart';
import 'package:culcul/features/profile/data/local/profile_cache_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_cache_repository.g.dart';

class UserInfoCacheRepository {
  final ProfileCacheDatabase _database;

  UserInfoCacheRepository(this._database);

  Future<ProfileUser?> getUser(
    String uid, {
    bool allowStale = false,
    DateTime? now,
  }) async {
    return _database.getUser(uid, allowStale: allowStale, now: now);
  }

  Future<void> saveUser(
    ProfileUser user, {
    DateTime? now,
    Duration ttl = profileUserCacheTtl,
  }) async {
    await _database.upsertUser(user, now: now, ttl: ttl);
  }

  Future<void> removeUser(String uid) async {
    await _database.deleteUser(uid);
  }

  Future<void> clearAllUsers() async {
    await _database.clearUsers();
  }
}

@Riverpod(keepAlive: true)
UserInfoCacheRepository userInfoCacheRepository(Ref ref) {
  return UserInfoCacheRepository(ref.watch(profileCacheDatabaseProvider));
}
