import 'dart:async';

import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScrollPrecacheBudget {
  const ScrollPrecacheBudget({
    required this.enabled,
    required this.prefetchCount,
    required this.maxConcurrency,
  });

  final bool enabled;
  final int prefetchCount;
  final int maxConcurrency;
}

ScrollPrecacheBudget resolveScrollPrecacheBudget({
  required int requestedCount,
  RuntimePerformancePolicy? runtimePolicy,
  PerformancePolicy? renderPolicy,
}) {
  final policy =
      runtimePolicy ??
      RuntimePerformancePolicy.fromRenderPolicy(
        renderPolicy ?? PerformancePolicyController.notifier.value,
      );
  if (!policy.allowImagePrefetch || !policy.allowsNonCriticalPrefetch) {
    return const ScrollPrecacheBudget(
      enabled: false,
      prefetchCount: 0,
      maxConcurrency: 0,
    );
  }

  final adjustedCount = (requestedCount * policy.networkPrefetchLimitFactor).floor();
  final prefetchCount = adjustedCount.clamp(1, requestedCount);
  final maxConcurrency = policy.networkPrefetchMaxConcurrency.clamp(1, prefetchCount);
  return ScrollPrecacheBudget(
    enabled: true,
    prefetchCount: prefetchCount,
    maxConcurrency: maxConcurrency,
  );
}

/// Precaches images for items that are about to scroll into view.
///
/// Monitors scroll velocity and, when scrolling is stable (not flinging),
/// prefetches the next [prefetchCount] images using [AppNetworkImagePrefetcher].
void useScrollPrecache({
  required ScrollController scrollController,
  required List<NetworkImagePrefetchSpec> Function(int firstVisibleIndex, int count)
  getUpcomingSpecs,
  int prefetchCount = 5,
  Duration debounce = const Duration(milliseconds: 300),
  RuntimePerformancePolicy? runtimePolicy,
}) {
  final context = useContext();
  final debounceTimer = useRef<Timer?>(null);
  final lastPrefetchedIndex = useRef<int>(-1);

  useEffect(() {
    void onScroll() {
      if (!scrollController.hasClients) return;

      final position = scrollController.position;
      // Skip during fling (fast scroll)
      if (position.isScrollingNotifier.value) return;

      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(debounce, () {
        if (!context.mounted) return;

        final budget = resolveScrollPrecacheBudget(
          requestedCount: prefetchCount,
          runtimePolicy: runtimePolicy,
        );
        if (!budget.enabled) return;

        // Estimate first visible index from scroll offset.
        // Use a rough estimate of 200px per item.
        final estimatedIndex = (position.pixels / 200).floor();

        if (estimatedIndex == lastPrefetchedIndex.value) return;
        lastPrefetchedIndex.value = estimatedIndex;

        final specs = getUpcomingSpecs(estimatedIndex, budget.prefetchCount);
        if (specs.isNotEmpty) {
          AppNetworkImagePrefetcher.prefetch(
            context,
            specs: specs,
            limit: budget.prefetchCount,
            maxConcurrency: budget.maxConcurrency,
          );
        }
      });
    }

    scrollController.addListener(onScroll);
    return () {
      scrollController.removeListener(onScroll);
      debounceTimer.value?.cancel();
    };
  }, [scrollController, runtimePolicy, prefetchCount, debounce]);
}
