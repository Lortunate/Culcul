import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:culcul/shared/contracts/relation_user_contract.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recently_followed_view_model.g.dart';

@riverpod
class RecentlyFollowed extends _$RecentlyFollowed {
  @override
  FutureOr<List<ProfileRelationUser>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final result = await ref
        .read(relationRepositoryProvider)
        .getFollowings(int.parse(authState.user!.id), page: 1);
    return result.when(success: (users) => users.take(20).toList(), failure: (_) => []);
  }
}
