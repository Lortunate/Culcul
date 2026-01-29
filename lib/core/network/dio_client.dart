import 'package:cilixili/core/constants/api_constants.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'User-Agent': ApiConstants.userAgent,
        'Referer': ApiConstants.referer,
        'Accept': 'application/json, text/plain, */*',
      },
    ),
  );

  dio.interceptors.addAll([
    if (kDebugMode)
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    InterceptorsWrapper(
      onError: (DioException e, handler) {
        final message = switch (e.type) {
          DioExceptionType.connectionTimeout => t.error.connection_timeout,
          DioExceptionType.sendTimeout => t.error.send_timeout,
          DioExceptionType.receiveTimeout => t.error.receive_timeout,
          DioExceptionType.badResponse => t.error.bad_response(
            code: e.response?.statusCode?.toString() ?? '',
          ),
          DioExceptionType.cancel => t.error.cancel,
          _ => t.error.network,
        };
        return handler.next(e.copyWith(message: message));
      },
    ),
  ]);

  return dio;
}
