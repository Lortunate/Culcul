import 'package:culcul/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor extends Interceptor {
  static final _stripKeys = {'w_rid', 'wts', '_', 'force_refresh'};

  final CacheStore _store;

  CacheInterceptor(this._store);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method != 'GET') {
      return handler.next(options);
    }

    if (options.queryParameters['force_refresh'] == true) {
      options.queryParameters.remove('force_refresh');
      final cacheOptions = CacheOptions(
        store: _store,
        policy: CachePolicy.refresh,
        keyBuilder: _generateKey,
      );
      options.extra.addAll(cacheOptions.toExtra());
      return handler.next(options);
    }

    final ttlSeconds = ApiConstants.cacheConfig[options.path];
    if (ttlSeconds != null) {
      final cacheOptions = CacheOptions(
        store: _store,
        policy: CachePolicy.forceCache,
        maxStale: Duration(seconds: ttlSeconds),
        keyBuilder: _generateKey,
      );
      options.extra.addAll(cacheOptions.toExtra());
    }

    handler.next(options);
  }

  static String _generateKey(RequestOptions options) {
    return buildCacheKey(options.path, options.queryParameters);
  }

  static String buildCacheKey(String path, Map<String, dynamic> queryParameters) {
    if (queryParameters.isEmpty) {
      return 'api_cache_$path';
    }

    // Check if any strip-eligible keys exist before copying the map
    final hasStrippable = queryParameters.keys.any(_stripKeys.contains);

    if (!hasStrippable) {
      // No keys to strip — build key directly without map copy
      if (queryParameters.length == 1) {
        final entry = queryParameters.entries.first;
        return 'api_cache_$path|${entry.key}=${entry.value}';
      }
      final sortedKeys = queryParameters.keys.toList()..sort();
      final buffer = StringBuffer('api_cache_$path|');
      for (var i = 0; i < sortedKeys.length; i++) {
        if (i > 0) buffer.write('&');
        final key = sortedKeys[i];
        final value = queryParameters[key];
        buffer.write(key);
        buffer.write('=');
        if (value is List) {
          buffer.write(value.join(','));
        } else {
          buffer.write(value);
        }
      }
      return buffer.toString();
    }

    // Has strippable keys — filter and build
    final params = <String, dynamic>{};
    queryParameters.forEach((key, value) {
      if (!_stripKeys.contains(key)) {
        params[key] = value;
      }
    });

    if (params.isEmpty) {
      return 'api_cache_$path';
    }

    if (params.length == 1) {
      final entry = params.entries.first;
      return 'api_cache_$path|${entry.key}=${entry.value}';
    }

    final sortedKeys = params.keys.toList()..sort();
    final buffer = StringBuffer('api_cache_$path|');
    for (var i = 0; i < sortedKeys.length; i++) {
      if (i > 0) buffer.write('&');
      final key = sortedKeys[i];
      final value = params[key];
      buffer.write(key);
      buffer.write('=');
      if (value is List) {
        buffer.write(value.join(','));
      } else {
        buffer.write(value);
      }
    }
    return buffer.toString();
  }
}
