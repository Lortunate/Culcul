import 'dart:io';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryInterval;
  final int maxRetryDelayMs;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryInterval = 300,
    this.maxRetryDelayMs = 2000,
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retries = extra['retries'] as int? ?? 0;

    if (retries < maxRetries && _shouldRetry(err)) {
      final delayMs = _calculateDelayMs(retries);
      if (delayMs > 0) {
        await Future.delayed(Duration(milliseconds: delayMs));
      }

      try {
        extra['retries'] = retries + 1;
        final response = await _retry(err, extra);

        return handler.resolve(response);
      } catch (_) {
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

  Future<Response<dynamic>> _retry(DioException err, Map<String, dynamic> extra) async {
    final requestOptions = err.requestOptions;
    final retryOptions = requestOptions.copyWith(extra: extra);
    return dio.fetch(retryOptions);
  }

  int _calculateDelayMs(int retries) {
    final multiplier = 1 << retries.clamp(0, 6);
    final delayMs = retryInterval * multiplier;
    if (delayMs > maxRetryDelayMs) {
      return maxRetryDelayMs;
    }
    return delayMs;
  }
}
