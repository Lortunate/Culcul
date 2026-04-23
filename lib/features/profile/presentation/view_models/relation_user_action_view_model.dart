import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relation_user_action_view_model.g.dart';

@riverpod
class RelationUserActionViewModel extends _$RelationUserActionViewModel {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<AppError?> toggleFollow({required int mid, required bool isFollow}) async {
    state = const AsyncLoading();
    final result = await ref
        .read(profileRepositoryProvider)
        .modifyRelation(mid: mid, isFollow: isFollow);
    state = const AsyncData(null);
    return result.errorOrNull;
  }
}
