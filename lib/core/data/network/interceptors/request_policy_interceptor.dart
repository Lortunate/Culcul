import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Unified request policy interceptor handling timeouts, endpoint policies, and cache.
///
/// Replaces NetworkQualityInterceptor and EndpointCacheOptionsInterceptor.
class RequestPolicyInterceptor extends Interceptor {
  static const String keepRequestTimeoutExtra = 'keep_request_timeout';
  static final _cacheStripKeys = {'w_rid', 'wts', '_', 'force_refresh'};

  final Ref _ref;
  final CacheStore _store;
  NetworkQualityPolicy? _cachedPolicy;

  RequestPolicyInterceptor(this._ref, this._store);

  void invalidatePolicyCache() {
    _cachedPolicy = null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Step 1: Resolve endpoint policy
    final endpointPolicy = EndpointPolicyResolver(
      runtimePolicy: _ref.read(runtimePerformancePolicyProvider),
    ).resolve(options);
    options.extra[EndpointPolicy.resolvedPolicyExtra] = endpointPolicy;

    // Step 2: Apply network timeouts
    if (options.extra[keepRequestTimeoutExtra] != true) {
      final NetworkQualityPolicy policy;
      final cachedPolicy = _cachedPolicy;
      if (cachedPolicy != null) {
        policy = cachedPolicy;
      } else {
        policy = _ref.read(networkQualityPolicyProvider);
        _cachedPolicy = policy;
      }
      options.connectTimeout = policy.connectTimeout;
      options.receiveTimeout = policy.receiveTimeout;
      options.sendTimeout = policy.sendTimeout;
    }

    // Step 3: Apply cache options for GET requests
    if (options.method == 'GET') {
      if (options.queryParameters['force_refresh'] == true) {
        options.queryParameters.remove('force_refresh');
        final cacheOptions = CacheOptions(
          store: _store,
          policy: CachePolicy.refresh,
          keyBuilder: (options) => buildCacheKey(options.path, options.queryParameters),
        );
        options.extra.addAll(cacheOptions.toExtra());
      } else {
        final cacheTtl = endpointPolicy.cacheTtl;
        if (cacheTtl != null) {
          final cacheOptions = CacheOptions(
            store: _store,
            policy: CachePolicy.forceCache,
            maxStale: cacheTtl,
            keyBuilder: (options) => buildCacheKey(options.path, options.queryParameters),
          );
          options.extra.addAll(cacheOptions.toExtra());
        }
      }
    }

    handler.next(options);
  }

  static String buildCacheKey(String path, Map<String, dynamic> queryParameters) {
    if (queryParameters.isEmpty) {
      return 'api_cache_$path';
    }

    final hasStrippable = queryParameters.keys.any(_cacheStripKeys.contains);

    if (!hasStrippable) {
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

    final params = <String, dynamic>{};
    queryParameters.forEach((key, value) {
      if (!_cacheStripKeys.contains(key)) {
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
