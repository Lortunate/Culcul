import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  static const String retriesExtra = 'retries';
  static const String disableRetryExtra = 'disable_retry';

  final Dio dio;
  final int maxRetries;
  final int baseRetryDelayMs;
  final int maxRetryDelayMs;
  final math.Random _random;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.baseRetryDelayMs = 250,
    this.maxRetryDelayMs = 2500,
    math.Random? random,
  }) : _random = random ?? math.Random();

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final retries = requestOptions.extra[retriesExtra] as int? ?? 0;

    if (retries < maxRetries && _shouldRetry(err)) {
      final delayMs = _resolveDelayMs(err, retries);
      if (delayMs > 0) {
        await Future.delayed(Duration(milliseconds: delayMs));
      }

      try {
        requestOptions.extra[retriesExtra] = retries + 1;
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (_) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    final requestOptions = err.requestOptions;
    if (requestOptions.extra[disableRetryExtra] == true) {
      return false;
    }
    if (requestOptions.cancelToken?.isCancelled == true) {
      return false;
    }
    if (!_isIdempotentRequest(requestOptions)) {
      return false;
    }

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }

    if (err.type == DioExceptionType.badResponse &&
        _isRetryableStatusCode(err.response?.statusCode)) {
      return true;
    }

    return err.type == DioExceptionType.unknown && err.error is SocketException;
  }

  bool _isRetryableStatusCode(int? statusCode) {
    return switch (statusCode) {
      408 || 429 || 500 || 502 || 503 || 504 => true,
      _ => false,
    };
  }

  bool _isIdempotentRequest(RequestOptions requestOptions) {
    if (requestOptions.extra['force_retryable'] == true) {
      return true;
    }
    final method = requestOptions.method.toUpperCase();
    return method == 'GET' || method == 'HEAD' || method == 'OPTIONS';
  }

  /// Resolve retry delay: prefer Retry-After header for 429, else exponential backoff.
  int _resolveDelayMs(DioException err, int retries) {
    // Honor Retry-After header for 429 Too Many Requests
    if (err.response?.statusCode == 429) {
      final retryAfter = err.response?.headers.value('retry-after');
      if (retryAfter != null) {
        final seconds = int.tryParse(retryAfter);
        if (seconds != null && seconds > 0) {
          return math.min(seconds * 1000, maxRetryDelayMs);
        }
      }
    }
    return _calculateBackoffMs(retries);
  }

  int _calculateBackoffMs(int retries) {
    final exponent = retries.clamp(0, 6);
    final delayMs = baseRetryDelayMs * (1 << exponent);
    final boundedDelayMs = math.min(maxRetryDelayMs, delayMs);
    final jitterRatio = (_random.nextDouble() * 0.6) - 0.3;
    final jitteredDelay = (boundedDelayMs * (1 + jitterRatio)).round();
    return math.max(0, jitteredDelay);
  }
}
