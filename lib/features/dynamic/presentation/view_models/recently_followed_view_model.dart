import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
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

    try {
      final users = await ref
          .read(relationRepositoryProvider)
          .getFollowings(int.parse(authState.user!.id), page: 1);
      return users.take(20).toList();
    } catch (_) {
      return [];
    }
  }
}
