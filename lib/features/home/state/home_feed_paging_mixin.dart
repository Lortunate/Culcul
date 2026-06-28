import 'dart:async';

import 'package:culcul/core/models/video_model_contract.dart';
import 'package:culcul/core/data/network/interceptors/request_policy_interceptor.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:hooks_riverpod/hooks_riverpod.dart';

mixin HomeFeedPagingMixin on OffsetPagedAsyncNotifier<VideoModel> {
  Ref get ref;

  @override
  Object itemId(VideoModel item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<VideoModel> items) => items.isNotEmpty;

  Future<void> refresh() => refreshPage();

  Future<void> loadMore() => loadNextPage();

  Future<List<VideoModel>> loadFeedPage({
    required String perfChain,
    required int page,
    required bool forceRefresh,
    required Future<Result<List<VideoModel>, AppError>> Function({
      required int page,
      required bool forceRefresh,
    })
    fetchPage,
  }) async {
    final result = await fetchPage(page: page, forceRefresh: forceRefresh);
    if (forceRefresh) {
      DevLogger.log('feature', '$perfChain.silent_refresh_result', <String, Object?>{
        'success': result.isSuccess,
      });
    }
    return result.when(
      success: (data) => data,
      failure: (error) {
        DevLogger.log('feature', '$perfChain.load_error', <String, Object?>{
          'error': error,
        });
        return const <VideoModel>[];
      },
    );
  }

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
        .exists(RequestPolicyInterceptor.buildCacheKey(cachePath, cacheQuery));

    DevLogger.log('feature', '$perfChain initial_data', <String, Object?>{
      'items': items.length,
      'cache_present': hasCachedValue,
      'ms': stopwatch.elapsedMilliseconds,
    });

    if (hasCachedValue && items.isNotEmpty) {
      unawaited(
        Future<void>.microtask(
          () => refreshFirstPageSilently(() async {
            final stopwatch = Stopwatch()..start();
            final freshItems = await loadPage(1, forceRefresh: true);
            DevLogger.log('feature', '$perfChain silent_refresh_fetch', <String, Object?>{
              'items': freshItems.length,
              'ms': stopwatch.elapsedMilliseconds,
            });
            return freshItems;
          }),
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
      if (listEquals(previousItems, items)) {
        return;
      }
      state = AsyncData(items);
    } catch (_) {
      // Silent refresh must not disrupt already rendered cached content.
    }
  }
}
