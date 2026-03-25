import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_dynamic_controller.g.dart';

@Riverpod(keepAlive: true)
class UserDynamicNotifier extends _$UserDynamicNotifier {
  String? _offset;
  bool _hasMore = true;
  int _hostMid = 0;

  @override
  Future<List<DynamicItem>> build(int hostMid) async {
    _hostMid = hostMid;
    _offset = null;
    _hasMore = true;
    return _fetchFeed();
  }

  Future<List<DynamicItem>> _fetchFeed() async {
    final repository = ref.read(dynamicRepositoryProvider);
    final result = await repository.getSpaceDynamicFeed(
      hostMid: _hostMid,
      offset: _offset,
    );
    return result.when(
      success: (feed) {
        _offset = feed.offset;
        _hasMore = feed.hasMore;
        return feed.items;
      },
      failure: (e) => throw e,
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final oldState = state;
    if (oldState.asData?.value == null) return;

    state = AsyncLoading<List<DynamicItem>>().copyWithPrevious(oldState);

    try {
      final newItems = await _fetchFeed();

      final List<DynamicItem> previousItems = oldState.asData!.value;
      final existingIds = previousItems.map((e) => e.idStr).toSet();
      final uniqueNewItems = newItems
          .where((e) => !existingIds.contains(e.idStr))
          .toList();

      state = AsyncData([...previousItems, ...uniqueNewItems]);
    } catch (e, st) {
      state = AsyncError<List<DynamicItem>>(e, st).copyWithPrevious(oldState);
    }
  }

  Future<void> refresh() async {
    _offset = null;
    _hasMore = true;
    state = const AsyncLoading();
    try {
      final items = await _fetchFeed();
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
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

      final result = await ref.read(dynamicRepositoryProvider).likeDynamic(id, !isLiked);
      if (result.isFailure) {
        // Revert
        state = oldState;
      }
    }
  }
}

