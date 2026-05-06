import 'package:culcul/core/session/session_cookie_refresher.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenInterceptor extends QueuedInterceptor {
  static const String _tokenRefreshedExtra = 'token_refreshed';
  static const String _disableTokenRefreshExtra = 'disable_token_refresh';

  final Ref _ref;
  Future<void>? _refreshCookieFuture;

  TokenInterceptor(this._ref);

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data is Map) {
      final data = response.data as Map;
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
          // ignore
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
        }));
  }
}
