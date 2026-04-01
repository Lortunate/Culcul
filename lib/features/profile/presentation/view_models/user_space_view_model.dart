import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceNotifier extends _$UserSpaceNotifier {
  @override
  Future<ProfileUser> build(String mid) async {
    return ref.read(profileRepositoryProvider).getProfile(int.parse(mid));
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
