import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/cookie_jar_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cookie_jar/cookie_jar.dart';

class CsrfInterceptor extends Interceptor {
  final Ref _ref;

  CsrfInterceptor(this._ref);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey('x-bili-csrf')) {
      options.headers.remove('x-bili-csrf');

      try {
        final cookieJar = _ref.read(cookieJarProvider);
        final cookies = await cookieJar.loadForRequest(
          Uri.parse(ApiConstants.baseUrl),
        );
        final csrf = cookies
            .firstWhere(
              (c) => c.name == 'bili_jct',
              orElse: () => Cookie('bili_jct', ''),
            )
            .value;

        if (csrf.isEmpty) {
          throw const AuthException('CSRF token not found');
        }

        if (options.method.toUpperCase() == 'POST') {
          options.data ??= <String, dynamic>{};

          if (options.data is Map) {
            options.data = Map<String, dynamic>.from(options.data as Map);
            options.data['csrf'] = csrf;
            options.data['csrf_token'] = csrf;
          } else if (options.data is FormData) {
            (options.data as FormData).fields.add(MapEntry('csrf', csrf));
          }
        } else {
          options.queryParameters['csrf'] = csrf;
        }
      } catch (e) {
        if (e is AuthException) {
          return handler.reject(
            DioException(requestOptions: options, error: e),
          );
        }
      }
    }
    handler.next(options);
  }
}
