import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/features/auth/auth_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenInterceptor extends Interceptor {
  final Ref _ref;
  Future<void>? _refreshCookieFuture;

  TokenInterceptor(this._ref);

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data is Map) {
      final data = response.data as Map;
      final code = data['code'];

      if (code == -101) {
        if (response.requestOptions.extra['token_refreshed'] == true) {
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
            ..['token_refreshed'] = true;

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
    final inFlight = _refreshCookieFuture;
    if (inFlight != null) {
      await inFlight;
      return;
    }

    final authRepo = _ref.read(authRepositoryProvider);
    final refreshFuture = authRepo.checkAndRefreshCookie();
    _refreshCookieFuture = refreshFuture;
    try {
      await refreshFuture;
    } finally {
      if (identical(_refreshCookieFuture, refreshFuture)) {
        _refreshCookieFuture = null;
      }
    }
  }
}
