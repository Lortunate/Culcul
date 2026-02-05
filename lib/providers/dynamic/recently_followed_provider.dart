import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      final response = await repository.getFollowings(
        int.parse(authState.user!.id),
        ps: 20,
      );
      return response.list;
    } catch (e) {
      // Return empty list on error to avoid breaking the UI
      return [];
    }
  }
}
