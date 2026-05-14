import 'package:culcul/core/data/network/endpoint_policy.dart';
import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EndpointPolicy', () {
    EndpointPolicyResolver resolverFor(RuntimePerformancePolicy runtimePolicy) {
      return EndpointPolicyResolver(runtimePolicy: runtimePolicy);
    }

    final interactiveRuntime = RuntimePerformancePolicy.resolve(
      networkProfile: NetworkQualityProfile.fast,
      lifecycleState: AppLifecycleState.resumed,
      renderPolicy: const PerformancePolicy.normal(),
    );

    test('GET retries according to policy', () {
      final options = RequestOptions(path: '/x/web-interface/popular', method: 'GET');
      final policy = resolverFor(interactiveRuntime).resolve(options);

      expect(policy.canRetry(options, 0), isTrue);
      expect(policy.canRetry(options, policy.retryMaxAttempts), isFalse);
      expect(policy.retryableStatuses, containsAll(<int>[408, 429, 500, 502]));
    });

    test('POST does not retry by default', () {
      final options = RequestOptions(path: '/x/v2/reply/add', method: 'POST');
      final policy = resolverFor(interactiveRuntime).resolve(options);

      expect(policy.requestClass, EndpointRequestClass.mutation);
      expect(policy.retryUnsafeMethods, isFalse);
      expect(policy.canRetry(options, 0), isFalse);
    });

    test('cache TTL resolves from endpoint policy', () {
      final options = RequestOptions(path: '/x/web-interface/popular', method: 'GET');
      final policy = resolverFor(interactiveRuntime).resolve(options);

      expect(policy.cacheTtl, const Duration(seconds: 45));
      expect(policy.allowStaleCache, isTrue);
      expect(policy.hasCache, isTrue);
    });

    test('background policy lowers concurrency and disables prefetch', () {
      final backgroundRuntime = RuntimePerformancePolicy.resolve(
        networkProfile: NetworkQualityProfile.fast,
        lifecycleState: AppLifecycleState.paused,
        renderPolicy: const PerformancePolicy.normal(),
      );
      final options = RequestOptions(path: '/x/web-interface/popular', method: 'GET');
      final policy = resolverFor(backgroundRuntime).resolve(options);

      expect(policy.retryMaxAttempts, 1);
      expect(policy.allowPrefetch, isFalse);
    });
  });
}
