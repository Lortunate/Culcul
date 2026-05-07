import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/session/current_user_provider.dart';
import 'package:culcul/core/session/follow_list_provider.dart';
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
        .read(followListServiceProvider)
        .getFollowings(int.parse(session.uid), page: 1);
    return result.when(success: (users) => users.take(20).toList(), failure: (_) => []);
  }
}
