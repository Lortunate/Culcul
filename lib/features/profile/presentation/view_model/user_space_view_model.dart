import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';

part 'user_space_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceNotifier extends _$UserSpaceNotifier {
  @override
  Future<UserProfile> build(String mid) async {
    final repository = ref.read(profileRepositoryProvider);
    return repository.getProfile(int.parse(mid));
  }

  Future<void> toggleFollow() async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final newFollowStatus = !currentProfile.isFollowing;
    // Optimistic update
    state = AsyncData(currentProfile.copyWith(isFollowing: newFollowStatus));

    try {
      await ref
          .read(profileRepositoryProvider)
          .modifyRelation(mid: int.parse(currentProfile.id), isFollow: newFollowStatus);
    } catch (_) {
      // Revert if failed
      state = AsyncData(currentProfile);
      // TODO: Show error toast
    }
  }
}
