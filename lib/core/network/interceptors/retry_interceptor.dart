import 'dart:io';

import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final Ref _ref;
  final int maxRetries;
  final int retryInterval;
  final int maxRetryDelayMs;

  RetryInterceptor({
    required this.dio,
    required Ref ref,
    this.maxRetries = 3,
    this.retryInterval = 300,
    this.maxRetryDelayMs = 2000,
  }) : _ref = ref;

  static const _triedPresetIdsKey = 'bili_accel_tried_preset_ids';

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
        final response = await _retryWithOptionalFallback(err, extra);

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

  Future<Response<dynamic>> _retryWithOptionalFallback(
    DioException err,
    Map<String, dynamic> extra,
  ) async {
    final requestOptions = err.requestOptions;

    final fallbackPreset = await _resolveFallbackPreset(requestOptions, extra);
    final retryOptions = _resolveRetryOptions(
      requestOptions: requestOptions,
      fallbackPreset: fallbackPreset,
      extra: extra,
    );

    return dio.fetch(retryOptions);
  }

  Future<BiliAccelerationPreset?> _resolveFallbackPreset(
    RequestOptions requestOptions,
    Map<String, dynamic> extra,
  ) async {
    if (!isBiliAccelerationTargetHost(requestOptions.uri.host)) {
      return null;
    }

    final currentState = _ref.read(bilibiliAccelerationControllerProvider);
    final triedPresetIds = _readTriedPresetIds(extra);
    triedPresetIds.add(currentState.activePresetId);

    final fallbackPreset = await _ref
        .read(bilibiliAccelerationControllerProvider.notifier)
        .registerFailureAndTryFallback(
          failedPresetId: currentState.activePresetId,
          triedPresetIds: triedPresetIds,
        );
    if (fallbackPreset == null) {
      return null;
    }

    triedPresetIds.add(fallbackPreset.id);
    extra[_triedPresetIdsKey] = triedPresetIds.toList();
    return fallbackPreset;
  }

  RequestOptions _resolveRetryOptions({
    required RequestOptions requestOptions,
    required BiliAccelerationPreset? fallbackPreset,
    required Map<String, dynamic> extra,
  }) {
    if (fallbackPreset == null) {
      return requestOptions.copyWith(extra: extra);
    }

    final rewrittenUri = rewriteUriWithPreset(requestOptions.uri, fallbackPreset);
    if (_isAbsoluteUrl(requestOptions.path)) {
      return requestOptions.copyWith(path: rewrittenUri.toString(), extra: extra);
    }

    final authority = rewrittenUri.hasPort
        ? '${rewrittenUri.host}:${rewrittenUri.port}'
        : rewrittenUri.host;
    final rewrittenBaseUrl = '${rewrittenUri.scheme}://$authority';
    return requestOptions.copyWith(baseUrl: rewrittenBaseUrl, extra: extra);
  }

  Set<String> _readTriedPresetIds(Map<String, dynamic> extra) {
    final rawValues = extra[_triedPresetIdsKey];
    if (rawValues is List) {
      return rawValues.whereType<String>().toSet();
    }
    return <String>{};
  }

  bool _isAbsoluteUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
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
