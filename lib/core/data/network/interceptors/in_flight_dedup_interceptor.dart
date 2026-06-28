import 'dart:async';

import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:dio/dio.dart';

class InFlightDedupInterceptor extends Interceptor {
  static const String _dedupKeyExtra = 'in_flight_dedup_key';
  static const String disableDedupExtra = 'disable_in_flight_dedup';

  final Map<String, Completer<Response<dynamic>>> _inFlightByKey = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final endpointPolicy = EndpointPolicy.fromOptions(options);
    final shouldDeduplicate =
        options.method.toUpperCase() == 'GET' &&
        endpointPolicy?.dedupEnabled != false &&
        options.extra[disableDedupExtra] != true;
    if (!shouldDeduplicate) {
      handler.next(options);
      return;
    }

    final queryParams = options.queryParameters;
    final path = options.uri.path;
    late final String dedupKey;
    if (queryParams.isEmpty) {
      dedupKey = '${options.uri.host}$path';
    } else if (queryParams.length == 1) {
      final entry = queryParams.entries.first;
      dedupKey = '${options.uri.host}$path|${entry.key}=${entry.value}';
    } else {
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
      dedupKey = sb.toString();
    }
    final existing = _inFlightByKey[dedupKey];
    if (existing != null) {
      existing.future
          .then((response) {
            handler.resolve(
              Response<dynamic>(
                data: response.data,
                headers: response.headers,
                requestOptions: options,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                isRedirect: response.isRedirect,
                redirects: response.redirects,
                extra: Map<String, dynamic>.from(response.extra),
              ),
            );
          })
          .catchError((Object error) {
            if (error is DioException) {
              handler.reject(error.copyWith(requestOptions: options));
              return;
            }
            handler.reject(DioException(requestOptions: options, error: error));
          });
      return;
    }

    _inFlightByKey[dedupKey] = Completer<Response<dynamic>>();
    options.extra[_dedupKeyExtra] = dedupKey;
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final dedupKey = response.requestOptions.extra[_dedupKeyExtra];
    if (dedupKey is String) {
      final completer = _inFlightByKey.remove(dedupKey);
      if (completer != null && !completer.isCompleted) {
        completer.complete(response);
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final dedupKey = err.requestOptions.extra[_dedupKeyExtra];
    if (dedupKey is String) {
      final completer = _inFlightByKey.remove(dedupKey);
      if (completer != null && !completer.isCompleted) {
        completer.completeError(err, err.stackTrace);
      }
    }
    handler.next(err);
  }
}
