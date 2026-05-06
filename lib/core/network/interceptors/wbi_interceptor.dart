import 'dart:io';

import 'package:culcul/core/network/providers/wbi_helper_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WbiInterceptor extends Interceptor {
  final Ref _ref;

  WbiInterceptor(this._ref);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hasWbiHeader = options.headers.keys.any((k) => k.toLowerCase() == 'x-bili-wbi');
    final isWbiPath = options.uri.path.contains('/wbi/');
    final markedAsWbi = options.extra['requires_wbi'] == true;
    final requiresWbi = hasWbiHeader || isWbiPath || markedAsWbi;

    if (requiresWbi) {
      options.extra['requires_wbi'] = true;
      options.headers.removeWhere((key, value) => key.toLowerCase() == 'x-bili-wbi');

      _ensureCookieCount(options);

      try {
        final wbiHelper = _ref.read(wbiHelperProvider);
        await wbiHelper.updateKeys();

        final params = options.queryParameters;
        final signedParams = wbiHelper.sign(params);

        if (kDebugMode) {
          debugPrint('WbiInterceptor: Signed params for ${options.uri.path}');
        }

        options.queryParameters = signedParams;
      } catch (e, stack) {
        if (kDebugMode) {
          debugPrint('WbiInterceptor signing failed: $e\n$stack');
        }
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Wbi signing failed: $e',
            type: DioExceptionType.unknown,
          ),
        );
      }
    }
    handler.next(options);
  }

  void _ensureCookieCount(RequestOptions options) {
    final cookieHeader = options.headers[HttpHeaders.cookieHeader];
    if (cookieHeader is String) {
      final count = cookieHeader.split(';').where((e) => e.trim().isNotEmpty).length;
      if (count < 3) {
        final sb = StringBuffer(cookieHeader);
        for (var i = 0; i < 3 - count; i++) {
          sb.write('; dummy$i=0');
        }
        options.headers[HttpHeaders.cookieHeader] = sb.toString();
      }
    }
  }
}
