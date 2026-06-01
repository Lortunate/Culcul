import 'dart:math' as math;

import 'package:culcul/core/data/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/media/network_image_prefetch_specs.dart';
import 'package:flutter/material.dart';

class HomeFeedCacheTuning {
  final double constrainedNetworkFactor;
  final double normalNetworkFactor;
  final double minimalEffectsFactor;
  final double reducedEffectsFactor;
  final double minExtent;

  const HomeFeedCacheTuning({
    required this.constrainedNetworkFactor,
    required this.normalNetworkFactor,
    required this.minimalEffectsFactor,
    required this.reducedEffectsFactor,
    required this.minExtent,
  });
}

const HomeFeedCacheTuning homeGridFeedCacheTuning = HomeFeedCacheTuning(
  constrainedNetworkFactor: 0.72,
  normalNetworkFactor: 0.88,
  minimalEffectsFactor: 0.78,
  reducedEffectsFactor: 0.9,
  minExtent: 360,
);

const HomeFeedCacheTuning homePopularFeedCacheTuning = HomeFeedCacheTuning(
  constrainedNetworkFactor: 0.75,
  normalNetworkFactor: 0.9,
  minimalEffectsFactor: 0.8,
  reducedEffectsFactor: 0.92,
  minExtent: 320,
);

const int homePopularInitialPrefetchLimit = 6;

const double homeVideoFeedImageAspectRatio = 16 / 10;
const double homeLiveFeedImageAspectRatio = 16 / 9;

int resolveHomeGridPrefetchLimit(int crossAxisCount) => crossAxisCount * 2;

double estimateHomeGridItemWidth(BuildContext context, HomeGridLayoutSpec layout) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  final containerWidth = math.min(screenWidth, homeFeedMaxWidth);
  final columns = layout.gridDelegate.crossAxisCount;
  final spacing = layout.gridDelegate.crossAxisSpacing * (columns - 1);
  return (containerWidth - layout.padding.horizontal - spacing) / columns;
}

double resolveHomeFeedCacheExtent(
  double base, {
  required NetworkQualityPolicy networkPolicy,
  required PerformancePolicy perfPolicy,
  required HomeFeedCacheTuning tuning,
}) {
  var value = base;
  if (networkPolicy.profile == NetworkQualityProfile.constrained) {
    value *= tuning.constrainedNetworkFactor;
  } else if (networkPolicy.profile == NetworkQualityProfile.normal) {
    value *= tuning.normalNetworkFactor;
  }

  if (perfPolicy.level == RenderDegradeLevel.minimalEffects) {
    value *= tuning.minimalEffectsFactor;
  } else if (perfPolicy.level == RenderDegradeLevel.reducedEffects) {
    value *= tuning.reducedEffectsFactor;
  }

  return value.clamp(tuning.minExtent, base);
}

List<NetworkImagePrefetchSpec> buildHomeFeedImagePrefetchSpecs<T>(
  List<T> items, {
  required int startIndex,
  required int count,
  required double logicalWidth,
  required double pixelRatio,
  required double aspectRatio,
  required String Function(T item) imageUrl,
}) {
  return buildNetworkImagePrefetchSpecs(
    items,
    startIndex: startIndex,
    count: count,
    logicalWidth: logicalWidth,
    aspectRatio: aspectRatio,
    pixelRatio: pixelRatio,
    imageUrl: imageUrl,
  );
}

void prefetchHomeFeedImages(
  BuildContext context, {
  required List<NetworkImagePrefetchSpec> specs,
  required NetworkQualityPolicy networkPolicy,
  required int limit,
}) {
  AppNetworkImagePrefetcher.prefetch(
    context,
    specs: specs,
    limit: networkPolicy.resolvePrefetchLimit(limit),
    maxConcurrency: networkPolicy.prefetchMaxConcurrency,
    queueCapacity: networkPolicy.prefetchQueueCapacity,
    ttl: networkPolicy.prefetchKeyTtl,
    lruCapacity: networkPolicy.prefetchLruCapacity,
  );
}
