import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/services/relation_service.dart';
import 'package:culcul/features/auth/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recently_followed_view_model.g.dart';

@riverpod
class RecentlyFollowed extends _$RecentlyFollowed {
  @override
  FutureOr<List<ProfileRelationUser>> build() async {
    final session = ref.watch(currentUserProvider);
    if (session == null || !session.isLoggedIn) {
      return [];
    }

    final result = await ref
        .read(relationPortProvider)
        .getFollowings(int.parse(session.uid));
    return result.when(success: (users) => users.take(20).toList(), failure: (_) => []);
  }
}
