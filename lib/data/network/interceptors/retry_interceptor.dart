import 'dart:io';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int retryInterval;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryInterval = 1000,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final extra = err.requestOptions.extra;
    final retries = extra['retries'] as int? ?? 0;

    if (retries < maxRetries && _shouldRetry(err)) {
      await Future.delayed(Duration(milliseconds: retryInterval));
      
      try {
        extra['retries'] = retries + 1;
        final options = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
          extra: extra,
          responseType: err.requestOptions.responseType,
          contentType: err.requestOptions.contentType,
          validateStatus: err.requestOptions.validateStatus,
          receiveTimeout: err.requestOptions.receiveTimeout,
          sendTimeout: err.requestOptions.sendTimeout,
          listFormat: err.requestOptions.listFormat,
        );

        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          cancelToken: err.requestOptions.cancelToken,
          options: options,
          onSendProgress: err.requestOptions.onSendProgress,
          onReceiveProgress: err.requestOptions.onReceiveProgress,
        );
        
        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.type == DioExceptionType.unknown &&
            err.error != null &&
            err.error is SocketException);
  }
}
