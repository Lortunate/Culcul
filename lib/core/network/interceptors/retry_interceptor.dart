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
      final delayMs = _calculateDelayMs(retries);
      if (delayMs > 0) {
        await Future.delayed(Duration(milliseconds: delayMs));
      }

      try {
        final response = await _retry(
          err,
          Map<String, dynamic>.from(requestOptions.extra)..[retriesExtra] = retries + 1,
        );

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
    final method = requestOptions.method.toUpperCase();
    if (requestOptions.extra['force_retryable'] == true) {
      return true;
    }
    return method == 'GET' || method == 'HEAD' || method == 'OPTIONS';
  }

  Future<Response<dynamic>> _retry(DioException err, Map<String, dynamic> extra) async {
    final requestOptions = err.requestOptions;
    final retryOptions = requestOptions.copyWith(extra: extra);
    return dio.fetch(retryOptions);
  }

  int _calculateDelayMs(int retries) {
    final exponent = retries.clamp(0, 6);
    final delayMs = baseRetryDelayMs * (1 << exponent);
    final boundedDelayMs = math.min(maxRetryDelayMs, delayMs);
    final jitterRatio = (_random.nextDouble() * 0.6) - 0.3;
    final jitteredDelay = (boundedDelayMs * (1 + jitterRatio)).round();
    return math.max(0, jitteredDelay);
  }
}
