import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkQualityPolicy', () {
    test('constrained profile reduces prefetch limit', () {
      final policy = NetworkQualityPolicy.forProfile(NetworkQualityProfile.constrained);

      expect(policy.resolvePrefetchLimit(8), 4);
      expect(policy.prefetchMaxConcurrency, 1);
    });

    test('fast profile keeps prefetch limit and uses tighter retry budget', () {
      final policy = NetworkQualityPolicy.forProfile(NetworkQualityProfile.fast);

      expect(policy.resolvePrefetchLimit(8), 8);
      expect(policy.retryMaxAttempts, 2);
      expect(policy.retryBaseDelayMs, lessThan(250));
    });

    test('normal profile stays between fast and constrained', () {
      final policy = NetworkQualityPolicy.forProfile(NetworkQualityProfile.normal);

      expect(policy.resolvePrefetchLimit(8), 8);
      expect(policy.retryMaxAttempts, 3);
      expect(policy.connectionIdleTimeout, const Duration(seconds: 75));
    });
  });
}
