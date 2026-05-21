import 'dart:io';

import 'package:culcul/core/data/network/providers/wbi_helper_provider.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    if (!requiresWbi) {
      handler.next(options);
      return;
    }

    options.extra['requires_wbi'] = true;
    options.headers.removeWhere((key, value) => key.toLowerCase() == 'x-bili-wbi');

    _ensureCookieCount(options);

    try {
      final wbiHelper = _ref.read(wbiHelperProvider);
      // Skip await when keys are already fresh — avoids microtask overhead
      if (!wbiHelper.areKeysFresh) {
        await wbiHelper.updateKeys();
      }

      options.queryParameters = wbiHelper.sign(options.queryParameters);
    } catch (e, stack) {
      DevLogger.log('network', 'wbi.sign_failed', <String, Object?>{
        'error': e,
        'stack': stack,
      });
      return handler.reject(
        DioException(requestOptions: options, error: 'Wbi signing failed: $e'),
      );
    }

    handler.next(options);
  }

  void _ensureCookieCount(RequestOptions options) {
    final cookieHeader = options.headers[HttpHeaders.cookieHeader];
    if (cookieHeader is! String) return;

    var count = 0;
    for (var i = 0; i < cookieHeader.length; i++) {
      if (cookieHeader[i] == ';') count++;
    }
    count++; // last segment

    if (count < 3) {
      final sb = StringBuffer(cookieHeader);
      for (var i = 0; i < 3 - count; i++) {
        sb.write('; dummy$i=0');
      }
      options.headers[HttpHeaders.cookieHeader] = sb.toString();
    }
  }
}
