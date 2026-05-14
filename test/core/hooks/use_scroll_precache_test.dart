import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/hooks/use_scroll_precache.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveScrollPrecacheBudget', () {
    test('allows interactive image prefetch within runtime concurrency', () {
      final budget = resolveScrollPrecacheBudget(
        requestedCount: 6,
        runtimePolicy: RuntimePerformancePolicy.interactive(NetworkQualityProfile.fast),
      );

      expect(budget.enabled, isTrue);
      expect(budget.prefetchCount, 6);
      expect(budget.maxConcurrency, 3);
    });

    test('reduces count and concurrency for constrained runtime policy', () {
      final budget = resolveScrollPrecacheBudget(
        requestedCount: 6,
        runtimePolicy: RuntimePerformancePolicy.balanced(
          NetworkQualityProfile.constrained,
        ),
      );

      expect(budget.enabled, isTrue);
      expect(budget.prefetchCount, 3);
      expect(budget.maxConcurrency, 1);
    });

    test('disables image prefetch for background runtime policy', () {
      final budget = resolveScrollPrecacheBudget(
        requestedCount: 6,
        runtimePolicy: RuntimePerformancePolicy.background(NetworkQualityProfile.normal),
      );

      expect(budget.enabled, isFalse);
      expect(budget.prefetchCount, 0);
      expect(budget.maxConcurrency, 0);
    });
  });
}
