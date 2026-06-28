import 'dart:io';

import 'package:culcul/core/perf/dev_logger.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_store_provider.g.dart';

@Riverpod(keepAlive: true)
CacheStore cacheStore(Ref ref) {
  return _LazyFileCacheStore(() async {
    try {
      return await getTemporaryDirectory();
    } catch (error) {
      DevLogger.log('network', 'cache_store.temp_dir_fallback', <String, Object?>{
        'error': error,
      });
      return getApplicationDocumentsDirectory();
    }
  });
}

final class _LazyFileCacheStore extends CacheStore {
  _LazyFileCacheStore(this._resolveDirectory);

  final Future<Directory> Function() _resolveDirectory;
  Future<CacheStore>? _storeFuture;

  Future<CacheStore> _store() {
    return _storeFuture ??= _createStore();
  }

  Future<CacheStore> _createStore() async {
    final directory = await _resolveDirectory();
    return FileCacheStore('${directory.path}/http_cache');
  }

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    return (await _store()).clean(priorityOrBelow: priorityOrBelow, staleOnly: staleOnly);
  }

  @override
  Future<void> close() async {
    final storeFuture = _storeFuture;
    if (storeFuture == null) return;
    return (await storeFuture).close();
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    return (await _store()).delete(key, staleOnly: staleOnly);
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    return (await _store()).deleteFromPath(pathPattern, queryParams: queryParams);
  }

  @override
  Future<bool> exists(String key) async {
    return (await _store()).exists(key);
  }

  @override
  Future<CacheResponse?> get(String key) async {
    return (await _store()).get(key);
  }

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    return (await _store()).getFromPath(pathPattern, queryParams: queryParams);
  }

  @override
  Future<void> set(CacheResponse response) async {
    return (await _store()).set(response);
  }
}
