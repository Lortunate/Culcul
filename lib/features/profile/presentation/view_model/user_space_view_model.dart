import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/features/profile/application/use_case/profile_follow_use_case.dart';
import 'package:culcul/features/profile/application/use_case/profile_query_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceNotifier extends _$UserSpaceNotifier {
  @override
  Future<UserProfile> build(String mid) async {
    final result = await ref.read(profileQueryUseCasesProvider).getProfile(mid);
    return result.when(
      success: (value) => value,
      failure: (error) => throw Exception(error.message),
    );
  }

  Future<void> toggleFollow() async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final newFollowStatus = !currentProfile.isFollowing;
    // Optimistic update
    state = AsyncData(currentProfile.copyWith(isFollowing: newFollowStatus));

    final result = await ref
        .read(profileFollowUseCaseProvider)
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
