import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/interceptors/csrf_interceptor.dart';
import 'package:culcul/core/session/session_lifecycle_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TokenInterceptor extends QueuedInterceptor {
  static const String _tokenRefreshedExtra = 'token_refreshed';
  static const String _disableTokenRefreshExtra = 'disable_token_refresh';

  final Ref _ref;
  final CsrfInterceptor? _csrfInterceptor;
  Future<void>? _refreshCookieFuture;

  TokenInterceptor(this._ref, [this._csrfInterceptor]);

  @override
  Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final code = data['code'];

      if (code == -101) {
        if (response.requestOptions.extra[_tokenRefreshedExtra] == true ||
            response.requestOptions.extra[_disableTokenRefreshExtra] == true) {
          handler.next(response);
          return;
        }

        final path = response.requestOptions.path;
        if (path.contains('/passport-login/web/cookie/')) {
          handler.next(response);
          return;
        }

        try {
          await _ensureCookieRefreshed();

          final retryExtra = Map<String, dynamic>.from(response.requestOptions.extra)
            ..[_tokenRefreshedExtra] = true;

          final dio = _ref.read(dioClientProvider);
          final retryOptions = response.requestOptions.copyWith(extra: retryExtra);

          final newResponse = await dio.fetch<dynamic>(retryOptions);

          handler.resolve(newResponse);
          return;
        } catch (e) {
          debugPrint('TokenInterceptor: cookie refresh failed: $e');
        }
      }
    }
    handler.next(response);
  }

  Future<void> _ensureCookieRefreshed() async {
    await (_refreshCookieFuture ??= _ref
        .read(sessionCookieRefresherProvider)
        .refreshCookies()
        .whenComplete(() {
          _refreshCookieFuture = null;
          // Invalidate CSRF cache since cookies changed
          _csrfInterceptor?.invalidateCsrfCache();
        }));
  }
}
