import 'package:culcul/features/profile/application/profile_cache_port.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/data/local/profile_cache_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_repository.g.dart';

@riverpod
ProfileCacheRepositoryImpl profileCacheRepository(Ref ref) {
  return ProfileCacheRepositoryImpl(ref.watch(profileCacheDatabaseProvider));
}

class ProfileCacheRepositoryImpl implements ProfileCachePort {
  final ProfileCacheDatabase _database;

  ProfileCacheRepositoryImpl(this._database);

  @override
  Future<ProfileUser?> readProfile(String userId) async {
    return await _database.getUser(userId);
  }

  @override
  Future<void> writeProfile(ProfileUser profile) async {
    await _database.upsertUser(profile);
  }

  @override
  Future<void> clearProfile(String userId) async {
    await _database.deleteUser(userId);
  }

  @override
  Future<void> clearAll() async {
    await _database.clearUsers();
  }
}
