import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/interceptors/cache_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/features/dynamic/feature_scope.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_queries.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_feed_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_dynamic_view_model.g.dart';

// Architecture note: This view model reads the domain repository directly
// instead of routing through dynamic_workflows.dart. The dynamic application
// layer is reserved for multi-step orchestration, while this is a simple
// single-call feed query kept local for readability.
@Riverpod(keepAlive: true)
class UserDynamicNotifier extends _$UserDynamicNotifier
    with CursorPagedAsyncNotifier<DynamicItem, String>, DynamicFeedController {
  int _hostMid = 0;
  CancelToken? _activePageCancelToken;
  CancelToken? _silentRefreshCancelToken;

  @override
  Future<List<DynamicItem>> build(int hostMid) async {
    _hostMid = hostMid;
    ref.onDispose(() {
      _activePageCancelToken?.cancel('dynamic_user_space_feed_disposed');
      _silentRefreshCancelToken?.cancel('dynamic_user_space_silent_refresh_disposed');
    });
    final stopwatch = Stopwatch()..start();
    final items = await buildFirstPage();
    final cacheKey = CacheInterceptor.buildCacheKey(ApiConstants.dynamicSpaceFeed, {
      'host_mid': hostMid,
      'timezone_offset': -480,
      'features':
          'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
    });
    final hasCachedValue = await ref.read(cacheStoreProvider).exists(cacheKey);
    DevLogger.log('feature', 'dynamic.user_space_feed initial_data', <String, Object?>{
      'hostMid': hostMid,
      'items': items.length,
      'cache_present': hasCachedValue,
      'ms': stopwatch.elapsedMilliseconds,
    });
    if (hasCachedValue && items.isNotEmpty) {
      unawaited(Future<void>.delayed(Duration.zero, _refreshFirstPageSilently));
    }
    return items;
  }

  @override
  Future<CursorPage<DynamicItem, String>> fetchPage(String? currentCursor) async {
    _activePageCancelToken?.cancel('dynamic_user_space_page_replaced');
    final cancelToken = CancelToken();
    _activePageCancelToken = cancelToken;
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getSpaceDynamicFeed(
          SpaceDynamicFeedQuery(
            hostMid: _hostMid,
            offset: currentCursor,
            cancelToken: cancelToken,
          ),
        );
    return result.when(
      success: (feed) =>
          CursorPage(items: feed.items, nextCursor: feed.offset, hasMore: feed.hasMore),
      failure: (_) => const CursorPage(items: [], nextCursor: null, hasMore: false),
    );
  }

  @override
  Object itemId(DynamicItem item) => item.idStr;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> _refreshFirstPageSilently() async {
    final previousItems = state.asData?.value;
    if (previousItems == null || previousItems.isEmpty || state.isLoading) {
      return;
    }

    final stopwatch = Stopwatch()..start();
    _silentRefreshCancelToken?.cancel('dynamic_user_space_silent_refresh_replaced');
    final cancelToken = CancelToken();
    _silentRefreshCancelToken = cancelToken;
    final result = await ref
        .read(dynamicRepositoryProvider)
        .getSpaceDynamicFeed(
          SpaceDynamicFeedQuery(
            hostMid: _hostMid,
            forceRefresh: true,
            cancelToken: cancelToken,
          ),
        );
    if (!ref.mounted || state.isLoading) {
      return;
    }

    final nextFeed = result.dataOrNull;
    if (nextFeed == null || _sameItems(previousItems, nextFeed.items)) {
      DevLogger.log(
        'feature',
        'dynamic.user_space_feed silent_refresh_skip',
        <String, Object?>{
          'hostMid': _hostMid,
          'items': nextFeed?.items.length,
          'ms': stopwatch.elapsedMilliseconds,
        },
      );
      return;
    }
    DevLogger.log(
      'feature',
      'dynamic.user_space_feed silent_refresh_apply',
      <String, Object?>{
        'hostMid': _hostMid,
        'items': nextFeed.items.length,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    state = AsyncData(nextFeed.items);
  }

  bool _sameItems(List<DynamicItem> previous, List<DynamicItem> next) {
    if (previous.length != next.length) {
      return false;
    }

    for (var index = 0; index < previous.length; index++) {
      if (previous[index].idStr != next[index].idStr) {
        return false;
      }
    }
    return true;
  }
}
