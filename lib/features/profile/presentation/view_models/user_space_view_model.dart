import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceNotifier extends _$UserSpaceNotifier {
  @override
  Future<ProfileUser> build(String mid) async {
    final result = await ref.read(profileRepositoryProvider).getProfile(int.parse(mid));
    return result.dataOrNull ?? _fallbackProfile(mid);
  }

  Future<void> toggleFollow() async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final newFollowStatus = !currentProfile.isFollowing;
    // Optimistic update
    state = AsyncData(currentProfile.copyWith(isFollowing: newFollowStatus));

    final result = await ref
        .read(profileRepositoryProvider)
        .modifyRelation(mid: int.parse(currentProfile.id), isFollow: newFollowStatus);
    if (result.isFailure) {
      // Revert if failed.
      state = AsyncData(currentProfile);
    }
  }
}

ProfileUser _fallbackProfile(String id) {
  return ProfileUser(
    id: id,
    username: '',
    avatarUrl: null,
    bannerUrl: null,
    bio: null,
    location: null,
    followersCount: 0,
    followingCount: 0,
    videosCount: 0,
    dynamicCount: 0,
    likesCount: 0,
    level: 0,
    vipType: 0,
    vipStatus: 0,
    coins: null,
    bCoins: null,
    currentExp: null,
    nextExp: null,
    currentMinExp: null,
    isFollowing: false,
    isVerified: false,
    createdAt: null,
  );
}
