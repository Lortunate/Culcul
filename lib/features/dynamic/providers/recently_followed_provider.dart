import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';

part 'recently_followed_provider.g.dart';

@riverpod
class RecentlyFollowed extends _$RecentlyFollowed {
  @override
  FutureOr<List<RelationUser>> build() async {
    final authState = ref.watch(authProvider);
    if (!authState.isLoggedIn || authState.user == null) {
      return [];
    }

    final repository = ref.read(relationRepositoryProvider);
    // orderType: '' for recently followed (default)
    try {
      final data = await repository.getFollowings(int.parse(authState.user!.id), ps: 20);
      return data.list;
    } catch (_) {
      return [];
    }
  }
}
