import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/network/interceptors/cache_interceptor.dart';
import 'package:culcul/core/network/interceptors/csrf_interceptor.dart';
import 'package:culcul/core/network/interceptors/in_flight_dedup_interceptor.dart';
import 'package:culcul/core/network/interceptors/network_quality_interceptor.dart';
import 'package:culcul/core/network/interceptors/retry_interceptor.dart';
import 'package:culcul/core/network/interceptors/token_interceptor.dart';
import 'package:culcul/core/network/interceptors/wbi_interceptor.dart';
import 'package:culcul/core/network/network_quality_policy.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/utils/json_compute.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

Dio _createBaseDio(Ref ref, NetworkQualityPolicy networkPolicy) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: networkPolicy.connectTimeout,
      receiveTimeout: networkPolicy.receiveTimeout,
      sendTimeout: networkPolicy.sendTimeout,
      headers: {
        'User-Agent': ApiConstants.userAgent,
        'Referer': ApiConstants.referer,
        'Accept': 'application/json, text/plain, */*',
        'Accept-Encoding': 'gzip, deflate',
        'Connection': 'keep-alive',
      },
    ),
  );

  dio.httpClientAdapter = Http2Adapter(
    ConnectionManager(
      idleTimeout: networkPolicy.connectionIdleTimeout,
      onClientCreate: (_, config) {
        if (kDebugMode) {
          config.onBadCertificate = (_) => true;
        }
      },
    ),
  );

  dio.transformer = BackgroundTransformer()..jsonDecodeCallback = jsonDecodeCompute;

  final cookieJar = ref.read(cookieJarProvider);
  dio.interceptors.add(CookieManager(cookieJar));

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
  final networkPolicy = ref.read(networkQualityPolicyProvider);
  final dio = _createBaseDio(ref, networkPolicy);
  _addLogInterceptor(dio);
  return dio;
}

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final networkPolicy = ref.read(networkQualityPolicyProvider);
  final dio = _createBaseDio(ref, networkPolicy);
  final cacheStore = ref.read(cacheStoreProvider);

  final networkQualityInterceptor = NetworkQualityInterceptor(ref);

  // Invalidate cached policy when connectivity changes
  ref.listen(networkQualityPolicyProvider, (prev, next) {
    networkQualityInterceptor.invalidateCache();
  });

  // Interceptor chain order optimized for minimal overhead:
  // 1. Dedup first — cheapest check, avoids all downstream work for duplicates
  // 2. Network quality — applies timeouts (cached policy read)
  // 3. Cache — checks cache before expensive signing/retry setup
  // 4. Retry — wraps the signing interceptors so retries get fresh signatures
  // 5. CSRF + WBI — signing (only runs for marked requests)
  // 6. Token — last, handles auth refresh after all else fails
  dio.interceptors.add(InFlightDedupInterceptor());
  dio.interceptors.add(networkQualityInterceptor);
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
  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      maxRetries: networkPolicy.retryMaxAttempts,
      baseRetryDelayMs: networkPolicy.retryBaseDelayMs,
      maxRetryDelayMs: networkPolicy.retryMaxDelayMs,
    ),
  );
  final csrfInterceptor = CsrfInterceptor(ref);
  dio.interceptors.add(csrfInterceptor);
  dio.interceptors.add(WbiInterceptor(ref));

  _addLogInterceptor(dio);

  dio.interceptors.add(TokenInterceptor(ref, csrfInterceptor));

  return dio;
}
