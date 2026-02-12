import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/data/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenInterceptor extends Interceptor {
  final Ref _ref;

  TokenInterceptor(this._ref);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data is Map) {
      final data = response.data as Map;
      final code = data['code'];

      if (code == -101) {
        final path = response.requestOptions.path;
        if (path.contains('/passport-login/web/cookie/')) {
          handler.next(response);
          return;
        }

        try {
          final authRepo = _ref.read(authRepositoryProvider);
          await authRepo.checkAndRefreshCookie();

          final dio = _ref.read(dioClientProvider);
          final options = Options(
            method: response.requestOptions.method,
            headers: response.requestOptions.headers,
          );

          final newResponse = await dio.request(
            response.requestOptions.path,
            data: response.requestOptions.data,
            queryParameters: response.requestOptions.queryParameters,
            options: options,
          );

          handler.resolve(newResponse);
          return;
        } catch (e) {
          // ignore
        }
      }
    }
    handler.next(response);
  }
}
