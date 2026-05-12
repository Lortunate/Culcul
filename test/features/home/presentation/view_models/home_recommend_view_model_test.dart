import 'dart:async';

import 'package:culcul/features/home/data/home_repository_impl.dart';
import 'package:culcul/features/home/presentation/view_models/home_recommend_view_model.dart';
import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/interceptors/cache_interceptor.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'home recommend returns cached first page then silently applies fresh page',
    () async {
      final dataSource = _FakeHomeRepositoryImpl();
      final cacheKey = CacheInterceptor.buildCacheKey(ApiConstants.feedRcmd, {
        'fresh_type': 4,
        'ps': 20,
        'fresh_idx': 1,
        'fresh_idx_1h': 1,
      });
      final container = ProviderContainer(
        overrides: [
          homeRepositoryImplProvider.overrideWithValue(dataSource),
          cacheStoreProvider.overrideWithValue(_FakeCacheStore(keys: <String>{cacheKey})),
        ],
      );
      addTearDown(container.dispose);

      final initialItems = await container.read(homeRecommendProvider.future);
      expect(initialItems.first.title, 'cached');
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(dataSource.recommendForceRefreshCalls, 1);

      dataSource.completeRecommendRefresh();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final refreshedItems = container.read(homeRecommendProvider).requireValue;
      expect(refreshedItems.first.title, 'fresh');
    },
  );

  test('home recommend skips silent refresh when first page cache is absent', () async {
    final dataSource = _FakeHomeRepositoryImpl();
    final container = ProviderContainer(
      overrides: [
        homeRepositoryImplProvider.overrideWithValue(dataSource),
        cacheStoreProvider.overrideWithValue(_FakeCacheStore(keys: const <String>{})),
      ],
    );
    addTearDown(container.dispose);

    final initialItems = await container.read(homeRecommendProvider.future);
    expect(initialItems.first.title, 'cached');
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(dataSource.recommendForceRefreshCalls, 0);
  });
}

class _FakeHomeRepositoryImpl extends HomeRepositoryImpl {
  _FakeHomeRepositoryImpl() : super.test();

  int recommendForceRefreshCalls = 0;
  final Completer<Result<List<VideoModel>, AppError>> _recommendRefreshCompleter =
      Completer<Result<List<VideoModel>, AppError>>();

  @override
  Future<Result<List<VideoModel>, AppError>> fetchRecommendPage({
    required int page,
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      recommendForceRefreshCalls++;
      return _recommendRefreshCompleter.future;
    }
    return Success(<VideoModel>[_video(title: 'cached')]);
  }

  @override
  Future<Result<List<VideoModel>, AppError>> fetchPopularPage({
    required int page,
    bool forceRefresh = false,
  }) async {
    return Success(<VideoModel>[_video(title: 'popular')]);
  }

  void completeRecommendRefresh() {
    if (_recommendRefreshCompleter.isCompleted) {
      return;
    }
    _recommendRefreshCompleter.complete(Success(<VideoModel>[_video(title: 'fresh')]));
  }
}

class _FakeCacheStore implements CacheStore {
  final Set<String> keys;

  _FakeCacheStore({required this.keys});

  @override
  Future<bool> exists(String key) async => keys.contains(key);

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {}

  @override
  Future<void> close() async {}

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {}

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {}

  @override
  Future<CacheResponse?> get(String key) async => null;

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    return const <CacheResponse>[];
  }

  @override
  bool pathExists(String url, RegExp pathPattern, {Map<String, String?>? queryParams}) =>
      false;

  @override
  Future<void> set(CacheResponse response) async {}
}

VideoModel _video({required String title}) {
  return VideoModel(
    bvid: 'BV1',
    title: title,
    pic: 'https://example.com/pic.jpg',
    owner: const VideoOwner(mid: 1, name: 'owner', face: ''),
    stat: const VideoStat(
      view: 1,
      danmaku: 1,
      reply: 1,
      like: 1,
      coin: 1,
      favorite: 1,
      share: 1,
    ),
    duration: 120,
    pubDate: 0,
    desc: 'desc',
    rcmdReason: 'reason',
  );
}
