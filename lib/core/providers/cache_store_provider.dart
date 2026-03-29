import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_store_provider.g.dart';

@Riverpod(keepAlive: true)
CacheStore cacheStore(Ref ref) {
  throw UnimplementedError('cacheStoreProvider not initialized');
}
