import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_store_provider.g.dart';

CacheStore? _cacheStoreInstance;

void initializeCacheStore(CacheStore cacheStore) {
  _cacheStoreInstance = cacheStore;
}

@Riverpod(keepAlive: true)
CacheStore cacheStore(Ref ref) {
  final cacheStore = _cacheStoreInstance;
  if (cacheStore == null) {
    throw StateError('cacheStoreProvider not initialized');
  }
  return cacheStore;
}
