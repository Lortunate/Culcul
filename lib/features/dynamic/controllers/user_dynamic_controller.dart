import 'package:culcul/core/paging_mixin.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository.dart';

part 'user_dynamic_controller.g.dart';

@Riverpod(keepAlive: true)
class UserDynamicNotifier extends _$UserDynamicNotifier
    with CursorPagingMixin<DynamicItem, String> {
  int _hostMid = 0;

  @override
  Future<List<DynamicItem>> build(int hostMid) async {
    _hostMid = hostMid;
    cursor = null;
    hasMore = true;
    final firstPage = await fetchItems(cursor);
    cursor = firstPage.nextCursor;
    hasMore = firstPage.hasMore;
    return firstPage.items;
  }

  @override
  Future<CursorPage<DynamicItem, String>> fetchItems(String? currentCursor) async {
    final repository = ref.read(dynamicRepositoryProvider);
    final feed = await repository.getSpaceDynamicFeed(
      hostMid: _hostMid,
      offset: currentCursor,
    );
    return CursorPage(items: feed.items, nextCursor: feed.offset, hasMore: feed.hasMore);
  }

  Future<void> loadMore() async {
    await handleCursorLoadMore(
      state,
      (newState) => state = newState,
      (item) => item.idStr,
    );
  }

  Future<void> refresh() async {
    await handleCursorRefresh(state, (newState) => state = newState);
  }

  Future<void> toggleLike(String id, bool isLiked) async {
    final oldState = state;
    if (oldState.asData?.value == null) return;

    final List<DynamicItem> items = oldState.asData!.value;
    final index = items.indexWhere((element) => element.idStr == id);
    if (index == -1) return;

    final item = items[index];

    // Deep copy update logic
    final newLikeCount = isLiked ? item.likeCount - 1 : item.likeCount + 1;
    final newStatus = !isLiked;

    final newStatLike = item.modules.moduleStat?.like.copyWith(
      count: newLikeCount,
      status: newStatus,
    );

    if (item.modules.moduleStat != null && newStatLike != null) {
      final newModuleStat = item.modules.moduleStat!.copyWith(like: newStatLike);
      final newModules = item.modules.copyWith(moduleStat: newModuleStat);
      final newItem = item.copyWith(modules: newModules);

      final newItems = List<DynamicItem>.from(items);
      newItems[index] = newItem;
      state = AsyncData(newItems);

      try {
        await ref.read(dynamicRepositoryProvider).likeDynamic(id, !isLiked);
      } catch (_) {
        // Revert
        state = oldState;
      }
    }
  }
}
