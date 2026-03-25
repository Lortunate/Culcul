import 'package:culcul/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor extends Interceptor {
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

    if (ApiConstants.cacheConfig.containsKey(options.path)) {
      final duration = ApiConstants.cacheConfig[options.path]!;
      final cacheOptions = CacheOptions(
        store: _store,
        policy: CachePolicy.forceCache,
        maxStale: Duration(seconds: duration),
        keyBuilder: _generateKey,
      );
      options.extra.addAll(cacheOptions.toExtra());
    }

    handler.next(options);
  }

  static String _generateKey(RequestOptions options) {
    final params = Map<String, dynamic>.from(options.queryParameters);
    params.remove('w_rid');
    params.remove('wts');
    params.remove('_');
    params.remove('force_refresh');

    final sortedKeys = params.keys.toList()..sort();
    final sortedParams = sortedKeys.map((key) => '$key=${params[key]}').join('&');

    return 'api_cache_${options.path}_$sortedParams';
  }
}

