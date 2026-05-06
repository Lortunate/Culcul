import 'dart:async';

import 'package:culcul/shared/contracts/video_model_contract.dart';
import 'package:culcul/shared/network/interceptors/cache_interceptor.dart';
import 'package:culcul/core/perf/feature_flow_perf_logger.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/shared/pagination/paged_async_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin HomeFeedPagingMixin on OffsetPagedAsyncNotifier<VideoModel> {
  Ref get ref;

  @override
  Object itemId(VideoModel item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<VideoModel> items) => items.isNotEmpty;

  Future<void> refresh() => refreshPage();

  Future<void> loadMore() => loadNextPage();

  Future<List<VideoModel>> buildFirstPageWithSilentRefresh({
    required String perfChain,
    required String cachePath,
    required Map<String, Object?> cacheQuery,
    required Future<List<VideoModel>> Function(int page, {required bool forceRefresh})
    loadPage,
  }) async {
    final stopwatch = Stopwatch()..start();
    final items = await loadPage(1, forceRefresh: false);
    final hasCachedValue = await ref
        .read(cacheStoreProvider)
        .exists(CacheInterceptor.buildCacheKey(cachePath, cacheQuery));

    FeatureFlowPerfLogger.log(
      chain: perfChain,
      stage: 'initial_data',
      fields: <String, Object?>{
        'items': items.length,
        'cache_present': hasCachedValue,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );

    if (hasCachedValue && items.isNotEmpty) {
      unawaited(
        Future<void>.microtask(
          () => refreshFirstPageSilently(
            () => _loadFreshFirstPage(perfChain: perfChain, loadPage: loadPage),
          ),
        ),
      );
    }

    return items;
  }

  Future<void> refreshFirstPageSilently(
    Future<List<VideoModel>> Function() loadFreshFirstPage,
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

  Future<List<VideoModel>> _loadFreshFirstPage({
    required String perfChain,
    required Future<List<VideoModel>> Function(int page, {required bool forceRefresh})
    loadPage,
  }) async {
    final stopwatch = Stopwatch()..start();
    final items = await loadPage(1, forceRefresh: true);
    FeatureFlowPerfLogger.log(
      chain: perfChain,
      stage: 'silent_refresh_fetch',
      fields: <String, Object?>{
        'items': items.length,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    return items;
  }

  bool _sameItems(List<VideoModel> previousItems, List<VideoModel> nextItems) {
    if (previousItems.length != nextItems.length) {
      return false;
    }

    for (var index = 0; index < previousItems.length; index++) {
      if (previousItems[index] != nextItems[index]) {
        return false;
      }
    }
    return true;
  }
}
