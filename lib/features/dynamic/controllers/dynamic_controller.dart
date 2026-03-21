import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/core/utils/list_utils.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_controller.g.dart';

@riverpod
class DynamicNotifier extends _$DynamicNotifier {
  String _offset = '';
  bool _hasMore = true;
  late String _type;

  @override
  AsyncValue<List<DynamicItem>> build(String type) {
    _type = type;
    _offset = '';
    _hasMore = true;
    // We cannot call async _fetchFeed directly in sync build if we want to return loading.
    // But we can fire it.
    _fetchFeed();
    return const AsyncValue.loading();
  }

  Future<void> loadMore() async {
    if (state.isLoading || !_hasMore) return;
    await _fetchFeed();
  }

  Future<void> refresh() async {
    _offset = '';
    _hasMore = true;
    state = const AsyncValue.loading();
    await _fetchFeed();
  }

  Future<void> _fetchFeed() async {
    if (!_hasMore) return;

    final repo = ref.read(dynamicRepositoryProvider);
    final result = await repo.getFeed(type: _type, offset: _offset);

    // Use ResultUtils to handle the result
    switch (result) {
      case Success(value: final data):
        _hasMore = data.hasMore;
        _offset = data.offset;

        final newItems = data.items;

        if (state.value != null && _offset.isNotEmpty) {
          final mergedItems = ListUtils.mergeUnique(
            state.value!,
            newItems,
            idGetter: (item) => item.idStr,
          );
          state = AsyncValue.data(mergedItems);
        } else {
          state = AsyncValue.data(newItems);
        }

      case Failure(exception: final error):
        if (state.value == null) {
          state = AsyncValue.error(error, StackTrace.current);
        } else {
          // Toast?
        }
    }
  }

  Future<void> toggleLike(String dynamicId, bool isLiked) async {
    final currentList = state.asData?.value;
    if (currentList == null) return;

    final index = currentList.indexWhere((e) => e.idStr == dynamicId);
    if (index == -1) return;

    final item = currentList[index];

    // Optimistic update using the extension method
    final newItem = item.copyWithLike(!isLiked);

    final newList = List<DynamicItem>.from(currentList);
    newList[index] = newItem;
    state = AsyncValue.data(newList);

    final repo = ref.read(dynamicRepositoryProvider);
    final result = await repo.likeDynamic(dynamicId, !isLiked);

    if (result is Failure) {
      // Revert if failed
      if (state.value != null) {
        final revertList = List<DynamicItem>.from(state.value!);
        // Check index again in case list changed
        final revertIndex = revertList.indexWhere((e) => e.idStr == dynamicId);
        if (revertIndex != -1) {
          revertList[revertIndex] = item;
          state = AsyncValue.data(revertList);
        }
      }
    }
  }
}
