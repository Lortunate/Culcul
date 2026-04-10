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
  void onResponse(Response response, ResponseInterceptorHandler handler) {
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
    final sortedQueryEntries = options.queryParameters.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final query = sortedQueryEntries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
    final cookieHeader = options.headers['cookie'];
    return '${options.method}|${options.uri.scheme}|${options.uri.host}|'
        '${options.uri.port}|${options.uri.path}|$query|cookie=$cookieHeader';
  }

  void _completePendingSuccess(RequestOptions requestOptions, Response response) {
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
