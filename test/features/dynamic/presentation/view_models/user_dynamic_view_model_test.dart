import 'dart:async';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/interceptors/cache_interceptor.dart';
import 'package:culcul/core/network/request_cancel_token.dart';
import 'package:culcul/core/providers/cache_store_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/domain/repositories/dynamic_repository.dart';
import 'package:culcul/features/dynamic/presentation/view_models/user_dynamic_view_model.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('userDynamicProvider silently refreshes first page when cache exists', () async {
    final repository = _FakeDynamicRepository();
    final cacheKey = CacheInterceptor.buildCacheKey(ApiConstants.dynamicSpaceFeed, {
      'host_mid': 1,
      'timezone_offset': -480,
      'features':
          'itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote,decorationCard,onlyfansAssetsV2,forwardListHidden,ugcDelete',
    });
    final container = ProviderContainer(
      overrides: [
        dynamicRepositoryProvider.overrideWithValue(repository),
        cacheStoreProvider.overrideWithValue(_FakeCacheStore(keys: <String>{cacheKey})),
      ],
    );
    addTearDown(container.dispose);

    final initial = await container.read(userDynamicProvider(1).future);
    expect(initial.first.idStr, 'cached');
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(repository.forceRefreshCalls, 1);

    repository.completeRefresh();
    await Future<void>.delayed(const Duration(milliseconds: 10));

    final refreshed = container.read(userDynamicProvider(1)).requireValue;
    expect(refreshed.first.idStr, 'fresh');
  });

  test('disposing userDynamicProvider cancels in-flight request', () async {
    final repository = _FakeDynamicRepository(delayInitialLoad: true);
    final container = ProviderContainer(
      overrides: [dynamicRepositoryProvider.overrideWithValue(repository)],
    );

    container.read(userDynamicProvider(1));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    container.dispose();

    expect(repository.lastCancelToken?.isCancelled, isTrue);
    repository.completeRefresh();
  });
}

class _FakeDynamicRepository extends Fake implements DynamicRepository {
  int forceRefreshCalls = 0;
  final bool delayInitialLoad;
  final Completer<Result<DynamicData, AppError>> _refreshCompleter =
      Completer<Result<DynamicData, AppError>>();
  RequestCancelToken? lastCancelToken;

  _FakeDynamicRepository({this.delayInitialLoad = false});

  @override
  Future<Result<DynamicData, AppError>> getSpaceDynamicFeed(
    SpaceDynamicFeedQuery query,
  ) async {
    lastCancelToken = query.cancelToken;
    if (query.forceRefresh) {
      forceRefreshCalls++;
      return _refreshCompleter.future;
    }
    if (delayInitialLoad) {
      return _refreshCompleter.future;
    }
    return Success(_feed(id: 'cached'));
  }

  void completeRefresh() {
    if (_refreshCompleter.isCompleted) {
      return;
    }
    _refreshCompleter.complete(Success(_feed(id: 'fresh')));
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

DynamicData _feed({required String id}) {
  return DynamicData(
    hasMore: true,
    items: <DynamicItem>[_item(id)],
    offset: '',
    updateBaseline: '',
    updateNum: 0,
  );
}

DynamicItem _item(String id) {
  return DynamicItem(
    idStr: id,
    type: 'DYNAMIC_TYPE_WORD',
    visible: true,
    modules: const DynamicModules(
      moduleAuthor: ModuleAuthor(
        mid: 1,
        name: 'author',
        avatar: '',
        pubTime: '',
        pubAction: '',
      ),
      moduleDynamic: ModuleDynamic(),
    ),
  );
}
