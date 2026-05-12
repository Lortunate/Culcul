import 'dart:async';

import 'package:dio/dio.dart';

class InFlightDedupInterceptor extends Interceptor {
  static const String _dedupKeyExtra = 'in_flight_dedup_key';
  static const String disableDedupExtra = 'disable_in_flight_dedup';

  final Map<String, Completer<Response<dynamic>>> _inFlightByKey = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_shouldDeduplicate(options)) {
      handler.next(options);
      return;
    }

    final dedupKey = _buildDedupKey(options);
    final existing = _inFlightByKey[dedupKey];
    if (existing != null) {
      existing.future
          .then((response) {
            handler.resolve(_cloneResponseForRequest(response, options));
          })
          .catchError((Object error) {
            if (error is DioException) {
              handler.reject(error.copyWith(requestOptions: options));
              return;
            }
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.unknown,
                error: error,
              ),
            );
          });
      return;
    }

    _inFlightByKey[dedupKey] = Completer<Response<dynamic>>();
    options.extra[_dedupKeyExtra] = dedupKey;
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _completePendingSuccess(response.requestOptions, response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _completePendingFailure(err.requestOptions, err);
    handler.next(err);
  }

  bool _shouldDeduplicate(RequestOptions options) {
    return options.method.toUpperCase() == 'GET' &&
        options.extra[disableDedupExtra] != true;
  }

  String _buildDedupKey(RequestOptions options) {
    final queryParams = options.queryParameters;
    final path = options.uri.path;

    // Fast path: no query params — most common for simple GET endpoints
    if (queryParams.isEmpty) {
      return '${options.uri.host}$path';
    }

    // Fast path: single query param — avoid sort overhead
    if (queryParams.length == 1) {
      final entry = queryParams.entries.first;
      return '${options.uri.host}$path|${entry.key}=${entry.value}';
    }

    // General case: sort params for consistent key
    final sortedEntries = queryParams.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final sb = StringBuffer()
      ..write(options.uri.host)
      ..write(path)
      ..write('|');
    for (var i = 0; i < sortedEntries.length; i++) {
      if (i > 0) sb.write('&');
      final e = sortedEntries[i];
      sb
        ..write(e.key)
        ..write('=')
        ..write(e.value);
    }
    return sb.toString();
  }

  void _completePendingSuccess(RequestOptions requestOptions, Response<dynamic> response) {
    final dedupKey = requestOptions.extra[_dedupKeyExtra];
    if (dedupKey is! String) {
      return;
    }
    final completer = _inFlightByKey.remove(dedupKey);
    if (completer != null && !completer.isCompleted) {
      completer.complete(response);
    }
  }

  void _completePendingFailure(RequestOptions requestOptions, DioException err) {
    final dedupKey = requestOptions.extra[_dedupKeyExtra];
    if (dedupKey is! String) {
      return;
    }
    final completer = _inFlightByKey.remove(dedupKey);
    if (completer != null && !completer.isCompleted) {
      completer.completeError(err, err.stackTrace);
    }
  }

  Response<dynamic> _cloneResponseForRequest(
    Response<dynamic> response,
    RequestOptions requestOptions,
  ) {
    return Response<dynamic>(
      data: response.data,
      headers: response.headers,
      requestOptions: requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: Map<String, dynamic>.from(response.extra),
    );
  }
}
