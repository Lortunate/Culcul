import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
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
    final result = await repository.getFollowings(int.parse(authState.user!.id), ps: 20);

    return switch (result) {
      Success(value: final data) => data.list,
      Failure() => [],
    };
  }
}
