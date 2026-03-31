import 'dart:io';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryInterval;

  RetryInterceptor({required this.dio, this.maxRetries = 3, this.retryInterval = 1000});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retries = extra['retries'] as int? ?? 0;

    if (retries < maxRetries && _shouldRetry(err)) {
      await Future.delayed(Duration(milliseconds: retryInterval));

      try {
        extra['retries'] = retries + 1;
        final response = await _retryWithOptionalFallback(err, extra);

        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.type == DioExceptionType.unknown &&
            err.error != null &&
            err.error is SocketException);
  }

  Future<Response<dynamic>> _retryWithOptionalFallback(
    DioException err,
    Map<String, dynamic> extra,
  ) {
    final requestOptions = err.requestOptions;
    final fallbackBaseUrl = _resolveFallbackBaseUrl(err, requestOptions, extra);
    final fallbackPath = _resolveFallbackPath(requestOptions.path, fallbackBaseUrl);
    final retryOptions = requestOptions.copyWith(
      baseUrl: fallbackBaseUrl ?? requestOptions.baseUrl,
      path: fallbackPath,
      extra: extra,
    );
    return dio.fetch(retryOptions);
  }

  String? _resolveFallbackBaseUrl(
    DioException err,
    RequestOptions requestOptions,
    Map<String, dynamic> extra,
  ) {
    if (!_isFailedHostLookup(err)) {
      return null;
    }
    if (extra['dns_fallback_used'] == true) {
      return null;
    }
    final isPrimaryHost = requestOptions.uri.host == Uri.parse(ApiConstants.baseUrl).host;
    if (!isPrimaryHost) {
      return null;
    }
    extra['dns_fallback_used'] = true;
    return ApiConstants.baseUrlFallback;
  }

  bool _isFailedHostLookup(DioException err) {
    final error = err.error;
    return error is SocketException && error.message.contains('Failed host lookup');
  }

  String _resolveFallbackPath(String path, String? fallbackBaseUrl) {
    if (fallbackBaseUrl == null) {
      return path;
    }
    if (path.startsWith(ApiConstants.baseUrl)) {
      return path.replaceFirst(ApiConstants.baseUrl, fallbackBaseUrl);
    }
    return path;
  }
}
