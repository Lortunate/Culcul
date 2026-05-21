import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/data/network/interceptors/endpoint_cache_options_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/data/pagination/paged_async_notifier.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_videos_view_model.g.dart';

@Riverpod(keepAlive: true)
class UserSpaceVideosNotifier extends _$UserSpaceVideosNotifier
    with OffsetPagedAsyncNotifier<ProfileVideo> {
  int _mid = 0;
  String _order = 'pubdate';
  static const _userSpaceVideoPageSize = 30;
  CancelToken? _activePageCancelToken;
  CancelToken? _silentRefreshCancelToken;

  @override
  Future<List<ProfileVideo>> build(int mid, {String order = 'pubdate'}) async {
    _mid = mid;
    _order = order;
    ref.onDispose(() {
      _activePageCancelToken?.cancel('profile_space_videos_disposed');
      _silentRefreshCancelToken?.cancel('profile_space_videos_silent_refresh_disposed');
    });
    final stopwatch = Stopwatch()..start();
    final items = await buildFirstPage();
    final cacheKey = EndpointCacheOptionsInterceptor.buildCacheKey(
      ApiConstants.profileSpaceVideos,
      {'mid': mid, 'pn': 1, 'ps': _userSpaceVideoPageSize, 'order': order},
    );
    final hasCachedValue = await ref.read(cacheStoreProvider).exists(cacheKey);
    DevLogger.log('feature', 'profile.space_videos initial_data', <String, Object?>{
      'mid': mid,
      'order': order,
      'items': items.length,
      'cache_present': hasCachedValue,
      'ms': stopwatch.elapsedMilliseconds,
    });
    if (hasCachedValue && items.isNotEmpty) {
      unawaited(Future<void>.microtask(_refreshFirstPageSilently));
    }
    return items;
  }

  @override
  Future<List<ProfileVideo>> fetchPage(int page) async {
    _activePageCancelToken?.cancel('profile_space_videos_page_replaced');
    final cancelToken = CancelToken();
    _activePageCancelToken = cancelToken;
    final result = await ref
        .read(profileRepositoryProvider)
        .getSpaceVideos(mid: _mid, page: page, order: _order, cancelToken: cancelToken);
    return result.when(success: (data) => data, failure: (error) => throw error);
  }

  @override
  Object itemId(ProfileVideo item) => item.bvid;

  @override
  bool hasMoreAfterPage(List<ProfileVideo> items) =>
      items.length >= _userSpaceVideoPageSize;

  Future<void> loadMore() {
    return loadNextPage();
  }

  Future<void> refresh() {
    return refreshPage();
  }

  Future<void> _refreshFirstPageSilently() async {
    final previousItems = state.asData?.value;
    if (previousItems == null ||
        previousItems.isEmpty ||
        state.isLoading ||
        currentPage != 1) {
      return;
    }

    final stopwatch = Stopwatch()..start();
    _silentRefreshCancelToken?.cancel('profile_space_videos_silent_refresh_replaced');
    final cancelToken = CancelToken();
    _silentRefreshCancelToken = cancelToken;
    final result = await ref
        .read(profileRepositoryProvider)
        .getSpaceVideos(
          mid: _mid,
          order: _order,
          forceRefresh: true,
          cancelToken: cancelToken,
        );
    if (!ref.mounted || state.isLoading || currentPage != 1) {
      return;
    }

    final nextItems = result.dataOrNull;
    if (nextItems == null || _sameItems(previousItems, nextItems)) {
      DevLogger.log(
        'feature',
        'profile.space_videos silent_refresh_skip',
        <String, Object?>{
          'mid': _mid,
          'order': _order,
          'items': nextItems?.length,
          'ms': stopwatch.elapsedMilliseconds,
        },
      );
      return;
    }
    DevLogger.log(
      'feature',
      'profile.space_videos silent_refresh_apply',
      <String, Object?>{
        'mid': _mid,
        'order': _order,
        'items': nextItems.length,
        'ms': stopwatch.elapsedMilliseconds,
      },
    );
    state = AsyncData(nextItems);
  }

  bool _sameItems(List<ProfileVideo> previous, List<ProfileVideo> next) {
    if (previous.length != next.length) {
      return false;
    }

    for (var index = 0; index < previous.length; index++) {
      final a = previous[index];
      final b = next[index];
      if (a.bvid != b.bvid ||
          a.title != b.title ||
          a.pic != b.pic ||
          a.owner.name != b.owner.name ||
          a.stats.view != b.stats.view ||
          a.stats.danmaku != b.stats.danmaku ||
          a.reason != b.reason) {
        return false;
      }
    }
    return true;
  }
}
