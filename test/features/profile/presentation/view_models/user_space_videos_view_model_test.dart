import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/interceptors/cache_interceptor.dart';
import 'package:culcul/core/data/network/request_cancel_token.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart';
import 'package:culcul/features/profile/presentation/view_models/user_space_videos_view_model.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'userSpaceVideosProvider silently refreshes first page when cache exists',
    () async {
      final repository = _FakeProfileRepository();
      final cacheKey = CacheInterceptor.buildCacheKey(ApiConstants.profileSpaceVideos, {
        'mid': 1,
        'pn': 1,
        'ps': 30,
        'order': 'pubdate',
      });
      final container = ProviderContainer(
        overrides: [
          profileRepositoryProvider.overrideWithValue(repository),
          cacheStoreProvider.overrideWithValue(_FakeCacheStore(keys: <String>{cacheKey})),
        ],
      );
      addTearDown(container.dispose);

      final initial = await container.read(
        userSpaceVideosProvider(1, order: 'pubdate').future,
      );
      expect(initial.first.title, 'cached');
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(repository.forceRefreshCalls, 1);

      repository.completeRefresh();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final refreshed = container
          .read(userSpaceVideosProvider(1, order: 'pubdate'))
          .requireValue;
      expect(refreshed.first.title, 'fresh');
    },
  );

  test('disposing userSpaceVideosProvider cancels in-flight request', () async {
    final repository = _FakeProfileRepository(delayInitialLoad: true);
    final container = ProviderContainer(
      overrides: [profileRepositoryProvider.overrideWithValue(repository)],
    );

    container.read(userSpaceVideosProvider(1, order: 'pubdate'));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    container.dispose();

    expect(repository.lastCancelToken?.isCancelled, isTrue);
    repository.completeRefresh();
  });
}

class _FakeProfileRepository extends Fake implements ProfileRepository {
  int forceRefreshCalls = 0;
  final bool delayInitialLoad;
  final Completer<Result<List<ProfileVideo>, AppError>> _refreshCompleter =
      Completer<Result<List<ProfileVideo>, AppError>>();
  RequestCancelToken? lastCancelToken;

  _FakeProfileRepository({this.delayInitialLoad = false});

  @override
  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
    required int mid,
    int page = 1,
    String order = 'pubdate',
    bool forceRefresh = false,
    RequestCancelToken? cancelToken,
  }) async {
    lastCancelToken = cancelToken;
    if (forceRefresh) {
      forceRefreshCalls++;
      return _refreshCompleter.future;
    }
    if (delayInitialLoad) {
      return _refreshCompleter.future;
    }
    return Success(<ProfileVideo>[_video(title: 'cached')]);
  }

  void completeRefresh() {
    if (_refreshCompleter.isCompleted) {
      return;
    }
    _refreshCompleter.complete(Success(<ProfileVideo>[_video(title: 'fresh')]));
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

ProfileVideo _video({required String title}) {
  return ProfileVideo(
    aid: 1,
    bvid: 'BV1',
    title: title,
    pic: 'https://example.com/pic.jpg',
    tname: 'test',
    duration: 120,
    pubDate: 0,
    ctime: 0,
    desc: 'desc',
    state: 0,
    attribute: 0,
    tid: 1,
    owner: const VideoOwner(mid: 1, name: 'owner', face: ''),
    stats: const VideoStat(
      view: 1,
      danmaku: 1,
      reply: 1,
      like: 1,
      coin: 1,
      favorite: 1,
      share: 1,
    ),
    reason: 'reason',
    interVideo: false,
  );
}
