import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/bootstrap/providers/cache_store_provider.dart';
import 'package:culcul/core/bootstrap/providers/cookie_jar_provider.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

final _testNetworkPolicyProvider = StateProvider<NetworkQualityPolicy>(
  (ref) => NetworkQualityPolicy.forProfile(NetworkQualityProfile.fast),
);

void main() {
  test('dio client keeps default timeouts and retry policy in sync', () async {
    final container = ProviderContainer(
      overrides: [
        cacheStoreProvider.overrideWithValue(MemCacheStore()),
        cookieJarProvider.overrideWithValue(CookieJar()),
        networkQualityPolicyProvider.overrideWith(
          (ref) => ref.watch(_testNetworkPolicyProvider),
        ),
      ],
    );
    addTearDown(container.dispose);

    final fastPolicy = NetworkQualityPolicy.forProfile(NetworkQualityProfile.fast);
    final constrainedPolicy = NetworkQualityPolicy.forProfile(
      NetworkQualityProfile.constrained,
    );

    final dioSubscription = container.listen(dioClientProvider, (_, _) {});
    addTearDown(dioSubscription.close);
    final dio = dioSubscription.read();
    expect(dio.options.connectTimeout, fastPolicy.connectTimeout);
    expect(dio.options.receiveTimeout, fastPolicy.receiveTimeout);
    expect(dio.options.sendTimeout, fastPolicy.sendTimeout);
    expect(_retryInterceptor(dio).retries, fastPolicy.retryMaxAttempts);
    expect(
      _retryInterceptor(dio).retryDelays.first,
      Duration(milliseconds: fastPolicy.retryBaseDelayMs),
    );

    container.read(_testNetworkPolicyProvider.notifier).state = constrainedPolicy;
    await container.pump();

    expect(dio.options.connectTimeout, constrainedPolicy.connectTimeout);
    expect(dio.options.receiveTimeout, constrainedPolicy.receiveTimeout);
    expect(dio.options.sendTimeout, constrainedPolicy.sendTimeout);
    expect(_retryInterceptor(dio).retries, constrainedPolicy.retryMaxAttempts);
    expect(
      _retryInterceptor(dio).retryDelays.first,
      Duration(milliseconds: constrainedPolicy.retryBaseDelayMs),
    );
  });
}

RetryInterceptor _retryInterceptor(Dio dio) =>
    dio.interceptors.whereType<RetryInterceptor>().single;
