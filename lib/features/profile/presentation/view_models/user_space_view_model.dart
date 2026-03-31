import 'package:culcul/features/profile/application/profile_follow_workflows.dart';
import 'package:culcul/features/profile/application/profile_query_workflows.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceNotifier extends _$UserSpaceNotifier {
  @override
  Future<ProfileUser> build(String mid) async {
    final result = await ref.read(profileQueryWorkflowsProvider).getProfile(mid);
    return result.when(success: (value) => value, failure: (error) => throw error);
  }

  Future<void> toggleFollow() async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final newFollowStatus = !currentProfile.isFollowing;
    // Optimistic update
    state = AsyncData(currentProfile.copyWith(isFollowing: newFollowStatus));

    final result = await ref
        .read(profileFollowWorkflowsProvider)
        .call(
          ToggleProfileFollowCommand(
            mid: int.parse(currentProfile.id),
            isFollow: newFollowStatus,
          ),
        );
    if (result.isFailure) {
      // Revert if failed
      state = AsyncData(currentProfile);
    }
  }
}
