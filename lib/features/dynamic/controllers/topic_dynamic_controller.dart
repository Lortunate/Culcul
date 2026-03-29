import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topic_dynamic_controller.g.dart';

@riverpod
class TopicDynamicNotifier extends _$TopicDynamicNotifier {
  String? _offset;
  bool _hasMore = true;
  late int _topicId;

  @override
  Future<List<DynamicItem>> build({required int topicId}) async {
    _topicId = topicId;
    _offset = null;
    _hasMore = true;
    return _fetchFeed();
  }

  Future<List<DynamicItem>> _fetchFeed() async {
    final repository = ref.read(dynamicRepositoryProvider);
    final feed = await repository.getTopicFeed(topicId: _topicId, offset: _offset);
    _offset = feed.offset;
    _hasMore = feed.hasMore;
    return feed.items;
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
    state = AsyncLoading<List<DynamicItem>>().copyWithPrevious(state);
    try {
      final items = await _fetchFeed();
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError<List<DynamicItem>>(e, st).copyWithPrevious(state);
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

      try {
        await ref.read(dynamicRepositoryProvider).likeDynamic(id, !isLiked);
      } catch (_) {
        // Revert
        state = oldState;
      }
    }
  }
}

