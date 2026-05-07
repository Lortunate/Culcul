import 'dart:async';

import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/ui/widgets/app_network_image_prefetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Precaches images for items that are about to scroll into view.
///
/// Monitors scroll velocity and, when scrolling is stable (not flinging),
/// prefetches the next [prefetchCount] images using [AppNetworkImagePrefetcher].
void useScrollPrecache({
  required ScrollController scrollController,
  required List<NetworkImagePrefetchSpec> Function(
    int firstVisibleIndex,
    int count,
  ) getUpcomingSpecs,
  int prefetchCount = 5,
  Duration debounce = const Duration(milliseconds: 300),
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

        // Check performance policy — skip precaching on minimal effects
        final policy = PerformancePolicyController.notifier.value;
        if (policy.level == RenderDegradeLevel.minimalEffects) return;

        // Estimate first visible index from scroll offset.
        // Use a rough estimate of 200px per item.
        final estimatedIndex = (position.pixels / 200).floor();

        if (estimatedIndex == lastPrefetchedIndex.value) return;
        lastPrefetchedIndex.value = estimatedIndex;

        final specs = getUpcomingSpecs(estimatedIndex, prefetchCount);
        if (specs.isNotEmpty) {
          AppNetworkImagePrefetcher.prefetch(
            context,
            specs: specs,
            limit: prefetchCount,
            maxConcurrency: 2,
          );
        }
      });
    }

    scrollController.addListener(onScroll);
    return () {
      scrollController.removeListener(onScroll);
      debounceTimer.value?.cancel();
    };
  }, [scrollController]);
}
