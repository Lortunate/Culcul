import 'package:culcul/core/network/network_quality_policy.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/ui/widgets/app_network_image_prefetcher.dart';
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

  return value.clamp(tuning.minExtent, base).toDouble();
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
