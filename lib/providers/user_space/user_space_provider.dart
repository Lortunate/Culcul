import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_provider.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceNotifier extends _$UserSpaceNotifier {
  @override
  Future<UserProfile> build(String mid) async {
    final repository = ref.read(profileRepositoryProvider);
    final result = await repository.getProfile(int.parse(mid));
    return switch (result) {
      Success(value: final data) => data,
      Failure(exception: final e) => throw e,
    };
  }

  Future<void> toggleFollow() async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final newFollowStatus = !currentProfile.isFollowing;
    // Optimistic update
    state = AsyncData(currentProfile.copyWith(isFollowing: newFollowStatus));

    final result = await ref
        .read(profileRepositoryProvider)
        .modifyRelation(
          mid: int.parse(currentProfile.id),
          isFollow: newFollowStatus,
        );

    if (result is Failure) {
      // Revert if failed
      state = AsyncData(currentProfile);
      // TODO: Show error toast
    }
  }
}
