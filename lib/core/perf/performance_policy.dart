import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:flutter/foundation.dart';

enum RenderDegradeLevel { normal, reducedEffects, minimalEffects }

@immutable
class PerformancePolicy {
  final RenderDegradeLevel level;

  const PerformancePolicy._(this.level);

  const PerformancePolicy.normal() : this._(RenderDegradeLevel.normal);

  const PerformancePolicy.reducedEffects() : this._(RenderDegradeLevel.reducedEffects);

  const PerformancePolicy.minimalEffects() : this._(RenderDegradeLevel.minimalEffects);

  bool get blurEnabled => level == RenderDegradeLevel.normal;
  bool get shimmerEnabled => level != RenderDegradeLevel.minimalEffects;

  static PerformancePolicy fromFrameSummary(FrameTimingSummary? summary) {
    if (summary == null || summary.samples < 60) {
      return const PerformancePolicy.normal();
    }

    if (summary.jankRatio >= 0.35 ||
        summary.buildP95Us >= 14000 ||
        summary.rasterP95Us >= 14000) {
      return const PerformancePolicy.minimalEffects();
    }

    if (summary.jankRatio >= 0.18 ||
        summary.buildP95Us >= 10000 ||
        summary.rasterP95Us >= 10000) {
      return const PerformancePolicy.reducedEffects();
    }

    return const PerformancePolicy.normal();
  }
}

class PerformancePolicyController {
  PerformancePolicyController._();

  static final ValueNotifier<PerformancePolicy> notifier = _createNotifier();

  static ValueNotifier<PerformancePolicy> _createNotifier() {
    final notifier = ValueNotifier<PerformancePolicy>(
      PerformancePolicy.fromFrameSummary(FrameTimingSampler.summaryNotifier.value),
    );
    FrameTimingSampler.summaryNotifier.addListener(_syncPolicy);
    return notifier;
  }

  static void _syncPolicy() {
    final next = PerformancePolicy.fromFrameSummary(
      FrameTimingSampler.summaryNotifier.value,
    );
    if (notifier.value.level != next.level) {
      notifier.value = next;
    }
  }
}
