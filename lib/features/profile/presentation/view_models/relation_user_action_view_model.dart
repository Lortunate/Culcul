import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/profile/application/profile_follow_workflows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_user_action_view_model.g.dart';

@riverpod
class RelationUserActionViewModel extends _$RelationUserActionViewModel {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<AppError?> toggleFollow({required int mid, required bool isFollow}) async {
    state = const AsyncLoading();
    final result = await ref
        .read(profileFollowWorkflowsProvider)
        .call(ToggleProfileFollowCommand(mid: mid, isFollow: isFollow));
    state = const AsyncData(null);
    return result.errorOrNull;
  }
}
