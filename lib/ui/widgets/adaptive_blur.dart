import 'dart:ui';

import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:flutter/material.dart';

class AdaptiveBlur extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  final double jankRatioThreshold;

  const AdaptiveBlur({
    super.key,
    required this.child,
    this.sigmaX = 20,
    this.sigmaY = 20,
    this.jankRatioThreshold = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return ValueListenableBuilder<FrameTimingSummary?>(
      valueListenable: FrameTimingSampler.summaryNotifier,
      builder: (context, summary, child) {
        final shouldDegrade =
            disableAnimations ||
            (summary != null &&
                summary.samples >= 60 &&
                summary.jankRatio >= jankRatioThreshold);
        if (shouldDegrade) {
          return child!;
        }
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
