import 'package:culcul/core/network/network_quality_policy.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkQualityInterceptor extends Interceptor {
  static const String keepRequestTimeoutExtra = 'keep_request_timeout';

  final Ref _ref;

  NetworkQualityInterceptor(this._ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra[keepRequestTimeoutExtra] != true) {
      final policy = _ref.read(networkQualityPolicyProvider);
      options.connectTimeout = policy.connectTimeout;
      options.receiveTimeout = policy.receiveTimeout;
      options.sendTimeout = policy.sendTimeout;
      options.extra['network_quality_profile'] = policy.profile.name;
    }
    handler.next(options);
  }
}
