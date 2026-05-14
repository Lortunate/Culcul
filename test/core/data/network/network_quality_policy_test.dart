import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkQualityPolicy', () {
    test('uses fast-profile budgets for strong connectivity', () {
      final policy = NetworkQualityPolicy.forProfile(NetworkQualityProfile.fast);

      expect(policy.profile, NetworkQualityProfile.fast);
      expect(policy.connectTimeout, const Duration(seconds: 5));
      expect(policy.receiveTimeout, const Duration(seconds: 8));
      expect(policy.retryMaxAttempts, 2);
      expect(policy.prefetchMaxConcurrency, 3);
      expect(policy.prefetchQueueCapacity, 100);
      expect(policy.resolvePrefetchLimit(20), 20);
    });

    test('uses constrained budgets for offline or weak connectivity', () {
      final policy = NetworkQualityPolicy.forProfile(
        NetworkQualityProfile.constrained,
      );

      expect(policy.isConstrained, isTrue);
      expect(policy.connectTimeout, const Duration(seconds: 15));
      expect(policy.receiveTimeout, const Duration(seconds: 18));
      expect(policy.connectionIdleTimeout, const Duration(seconds: 45));
      expect(policy.prefetchMaxConcurrency, 1);
      expect(policy.prefetchQueueCapacity, 30);
      expect(policy.resolvePrefetchLimit(20), 10);
    });

    test('does not prefetch for empty or invalid base limits', () {
      final policy = NetworkQualityPolicy.forProfile(NetworkQualityProfile.normal);

      expect(policy.resolvePrefetchLimit(0), 0);
      expect(policy.resolvePrefetchLimit(-1), 0);
    });
  });
}
