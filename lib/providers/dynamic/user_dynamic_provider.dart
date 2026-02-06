import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/repositories/dynamic_repository.dart';
import 'package:culcul/domain/entities/dynamic_post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_dynamic_provider.g.dart';

@Riverpod(keepAlive: true)
class UserDynamicNotifier extends _$UserDynamicNotifier {
  String? _offset;
  bool _hasMore = true;
  int _hostMid = 0;

  @override
  Future<List<DynamicPost>> build(int hostMid) async {
    _hostMid = hostMid;
    _offset = null;
    _hasMore = true;
    return _fetchFeed();
  }

  Future<List<DynamicPost>> _fetchFeed() async {
    final repository = ref.read(dynamicRepositoryProvider);
    final result = await repository.getUserFeed(hostMid: _hostMid, offset: _offset);
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

    state = AsyncLoading<List<DynamicPost>>().copyWithPrevious(oldState);

    try {
      final newItems = await _fetchFeed();

      final previousItems = oldState.asData!.value;
      final existingIds = previousItems.map((e) => e.id).toSet();
      final uniqueNewItems = newItems
          .where((e) => !existingIds.contains(e.id))
          .toList();

      state = AsyncData([...previousItems, ...uniqueNewItems]);
    } catch (e, st) {
      state = AsyncError<List<DynamicPost>>(e, st).copyWithPrevious(oldState);
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

    final items = oldState.asData!.value;
    final index = items.indexWhere((element) => element.id == id);
    if (index == -1) return;

    final item = items[index];
    final newItem = item.copyWith(
      isLiked: !isLiked,
      likeCount: isLiked ? item.likeCount - 1 : item.likeCount + 1,
    );

    final newItems = List<DynamicPost>.from(items);
    newItems[index] = newItem;
    state = AsyncData(newItems);

    final result = await ref.read(dynamicRepositoryProvider).likeDynamic(id, !isLiked);
    if (result.isFailure) {
      // Revert
      state = oldState;
    }
  }
}
