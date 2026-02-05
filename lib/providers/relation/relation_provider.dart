// ignore_for_file: invalid_use_of_internal_member
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/mixins/paging_mixin.dart';
import 'package:culcul/repositories/relation_repository.dart';
import '../../data/models/relation/relation_model.dart';
import '../../core/providers/api_provider.dart';

part 'relation_provider.g.dart';

@riverpod
class Followings extends _$Followings with PagingMixin<RelationUser> {
  late int _vmid;

  @override
  Future<List<RelationUser>> build(int vmid) async {
    _vmid = vmid;
    page = 1;
    hasMore = true;
    return fetchItems(page);
  }

  @override
  Future<List<RelationUser>> fetchItems(int page) async {
    final repository = ref.read(relationRepositoryProvider);
    final response = await repository.getFollowings(_vmid, pn: page);
    hasMore = response.list.length >= 50;
    return response.list;
  }

  Future<void> loadMore() async {
    final oldState = state;
    if (oldState is! AsyncData || !hasMore || oldState.isLoading) return;

    state = AsyncLoading<List<RelationUser>>().copyWithPrevious(oldState);

    // PagingMixin's handleLoadMore logic adapted here since we need to pass vmid to fetchItems
    // Actually PagingMixin calls fetchItems(page). fetchItems implementation above uses vmid from build parameters.
    // So we can use handleLoadMore directly if PagingMixin logic is generic enough.
    // Let's check handleLoadMore in PagingMixin or just copy logic.
    // The home_popular_provider uses handleLoadMore.

    await handleLoadMore(
      oldState,
      (newState) => state = newState,
      (item) => item.mid.toString(),
    );
  }
}

@riverpod
class Followers extends _$Followers with PagingMixin<RelationUser> {
  late int _vmid;

  @override
  Future<List<RelationUser>> build(int vmid) async {
    _vmid = vmid;
    page = 1;
    hasMore = true;
    return fetchItems(page);
  }

  @override
  Future<List<RelationUser>> fetchItems(int page) async {
    final repository = ref.read(relationRepositoryProvider);
    final response = await repository.getFollowers(_vmid, pn: page);
    hasMore = response.list.length >= 50;
    return response.list;
  }

  Future<void> loadMore() async {
    final oldState = state;
    if (oldState is! AsyncData || !hasMore || oldState.isLoading) return;

    state = AsyncLoading<List<RelationUser>>().copyWithPrevious(oldState);
    await handleLoadMore(
      oldState,
      (newState) => state = newState,
      (item) => item.mid.toString(),
    );
  }
}
