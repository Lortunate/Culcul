import 'dart:io';

import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/core/network/interceptors/bili_acceleration_interceptor.dart';
import 'package:culcul/core/network/interceptors/cache_interceptor.dart';
import 'package:culcul/core/network/interceptors/csrf_interceptor.dart';
import 'package:culcul/core/network/interceptors/retry_interceptor.dart';
import 'package:culcul/core/network/interceptors/token_interceptor.dart';
import 'package:culcul/core/network/interceptors/wbi_interceptor.dart';
import 'package:culcul/core/providers/cache_store_provider.dart';
import 'package:culcul/core/providers/cookie_jar_provider.dart';
import 'package:culcul/core/utils/json_compute.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

Dio _createBaseDio(Ref ref) {
  ref.read(bilibiliAccelerationControllerProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'User-Agent': ApiConstants.userAgent,
        'Referer': ApiConstants.referer,
        'Accept': 'application/json, text/plain, */*',
        'Connection': 'keep-alive',
      },
    ),
  );

  dio.httpClientAdapter = Http2Adapter(
    ConnectionManager(
      idleTimeout: const Duration(seconds: 60),
      onClientCreate: (_, config) {
        config.onBadCertificate = (_) => true;
      },
    ),
  );

  dio.transformer = BackgroundTransformer()..jsonDecodeCallback = jsonDecodeCompute;

  final cookieJar = ref.read(cookieJarProvider);
  dio.interceptors.add(CookieManager(cookieJar));
  dio.interceptors.add(BiliAccelerationInterceptor(ref));

  return dio;
}

void _addLogInterceptor(Dio dio) {
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
Dio basicDio(Ref ref) {
  final dio = _createBaseDio(ref);
  _addLogInterceptor(dio);
  return dio;
}

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final dio = _createBaseDio(ref);
  final cacheStore = ref.read(cacheStoreProvider);

  dio.interceptors.add(CacheInterceptor(cacheStore));
  dio.interceptors.add(
    DioCacheInterceptor(
      options: CacheOptions(
        store: cacheStore,
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [500, 502, 503, 504],
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
        allowPostMethod: false,
      ),
    ),
  );
  dio.interceptors.add(RetryInterceptor(dio: dio, ref: ref));
  dio.interceptors.add(CsrfInterceptor(ref));
  dio.interceptors.add(WbiInterceptor(ref));

  _addLogInterceptor(dio);

  dio.interceptors.add(TokenInterceptor(ref));

  return dio;
}
