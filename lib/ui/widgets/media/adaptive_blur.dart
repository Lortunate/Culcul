import 'dart:ui';

import 'package:culcul/core/perf/performance_policy.dart';
import 'package:flutter/material.dart';

class AdaptiveBlur extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  final double jankRatioThreshold;
  final bool adaptToPerformancePolicy;

  const AdaptiveBlur({
    super.key,
    required this.child,
    this.sigmaX = 20,
    this.sigmaY = 20,
    this.jankRatioThreshold = 0.25,
    this.adaptToPerformancePolicy = true,
  });

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (!adaptToPerformancePolicy) {
      return _buildBlur(disableAnimations: disableAnimations, child: child);
    }

    return ValueListenableBuilder<PerformancePolicy>(
      valueListenable: PerformancePolicyController.notifier,
      builder: (context, policy, child) {
        final shouldDegrade =
            disableAnimations ||
            !policy.blurEnabled ||
            (jankRatioThreshold < 0.35 &&
                policy.level == RenderDegradeLevel.reducedEffects);
        if (shouldDegrade) {
          return child!;
        }
        return _buildBlur(disableAnimations: false, child: child!);
      },
      child: child,
    );
  }

  Widget _buildBlur({required bool disableAnimations, required Widget child}) {
    if (disableAnimations) {
      return child;
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child,
      ),
    );
  }
}
