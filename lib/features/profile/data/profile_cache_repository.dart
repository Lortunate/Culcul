import 'package:culcul/features/profile/data/profile_mapper.dart';
import 'package:culcul/features/profile/data/dtos/profile_dtos.dart';
import 'package:culcul/features/profile/data/user_info_cache_service.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/repositories/profile_cache_repository.dart'
    as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_repository.g.dart';

@riverpod
class ProfileCacheRepository extends _$ProfileCacheRepository
    implements domain.ProfileCacheRepository {
  @override
  Future<UserInfoCacheService> build() {
    return ref.watch(userInfoCacheServiceProvider.future);
  }

  Future<UserProfile?> read(String userId) async {
    final cache = await future;
    return await cache.getUser(userId);
  }

  Future<void> write(UserProfile profile) async {
    final cache = await future;
    await cache.saveUser(profile);
  }

  @override
  Future<ProfileUser?> readProfile(String userId) async {
    return (await read(userId))?.toDomain();
  }

  @override
  Future<void> writeProfile(ProfileUser profile) async {
    await write(
      UserProfile(
        id: profile.id,
        username: profile.username,
        avatarUrl: profile.avatarUrl,
        bannerUrl: profile.bannerUrl,
        bio: profile.bio,
        location: profile.location,
        followersCount: profile.followersCount,
        followingCount: profile.followingCount,
        videosCount: profile.videosCount,
        dynamicCount: profile.dynamicCount,
        likesCount: profile.likesCount,
        level: profile.level,
        vipType: profile.vipType,
        vipStatus: profile.vipStatus,
        coins: profile.coins,
        bCoins: profile.bCoins,
        currentExp: profile.currentExp,
        nextExp: profile.nextExp,
        currentMinExp: profile.currentMinExp,
        isFollowing: profile.isFollowing,
        isVerified: profile.isVerified,
        createdAt: profile.createdAt,
      ),
    );
  }
}
