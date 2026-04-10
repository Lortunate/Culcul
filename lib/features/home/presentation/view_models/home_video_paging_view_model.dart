import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:culcul/features/home/domain/entities/home_video.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin HomeVideoPagingViewModel on OffsetPagedAsyncNotifier<HomeVideo> {
  @override
  Object itemId(HomeVideo item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<HomeVideo> items) => items.isNotEmpty;

  Future<void> refresh() => refreshPage();

  Future<void> loadMore() => loadNextPage();

  Future<void> refreshFirstPageSilently(
    Future<List<HomeVideo>> Function() loadFreshFirstPage,
  ) async {
    final previousState = state;
    final previousItems = previousState.asData?.value;
    if (previousItems == null || previousState.isLoading || currentPage != 1) {
      return;
    }

    try {
      final items = await loadFreshFirstPage();
      if (state.isLoading || currentPage != 1) {
        return;
      }
      if (_sameItems(previousItems, items)) {
        return;
      }
      state = AsyncData(items);
    } catch (_) {
      // Silent refresh must not disrupt already rendered cached content.
    }
  }

  bool _sameItems(List<HomeVideo> previousItems, List<HomeVideo> nextItems) {
    if (previousItems.length != nextItems.length) {
      return false;
    }

    for (var index = 0; index < previousItems.length; index++) {
      final previous = previousItems[index];
      final next = nextItems[index];
      if (previous.bvid != next.bvid ||
          previous.title != next.title ||
          previous.pic != next.pic ||
          previous.owner.name != next.owner.name ||
          previous.stats.view != next.stats.view ||
          previous.stats.danmaku != next.stats.danmaku ||
          previous.rcmdReason != next.rcmdReason) {
        return false;
      }
    }
    return true;
  }
}
