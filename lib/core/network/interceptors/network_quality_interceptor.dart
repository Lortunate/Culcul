import 'package:culcul/core/network/network_quality_policy.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkQualityInterceptor extends Interceptor {
  static const String keepRequestTimeoutExtra = 'keep_request_timeout';

  final Ref _ref;
  NetworkQualityPolicy? _cachedPolicy;

  NetworkQualityInterceptor(this._ref);

  NetworkQualityPolicy _getPolicy() {
    final cached = _cachedPolicy;
    if (cached != null) return cached;
    final policy = _ref.read(networkQualityPolicyProvider);
    _cachedPolicy = policy;
    return policy;
  }

  void invalidateCache() {
    _cachedPolicy = null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[keepRequestTimeoutExtra] != true) {
      final policy = _getPolicy();
      options.connectTimeout = policy.connectTimeout;
      options.receiveTimeout = policy.receiveTimeout;
      options.sendTimeout = policy.sendTimeout;
    }
    handler.next(options);
  }
}
