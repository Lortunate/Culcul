import 'package:culcul/core/perf/performance_policy.dart';
import 'package:flutter/material.dart';

class AppShimmer extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const AppShimmer({super.key, required this.child, this.enabled = true});

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AppShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return ValueListenableBuilder<PerformancePolicy>(
      valueListenable: PerformancePolicyController.notifier,
      builder: (context, policy, child) {
        final shouldAnimate =
            widget.enabled && !disableAnimations && policy.shimmerEnabled;

        _syncAnimation(shouldAnimate);
        if (!shouldAnimate) {
          return widget.child;
        }

        final colorScheme = Theme.of(context).colorScheme;
        final baseColor = colorScheme.surfaceContainerHighest.withValues(alpha: 0.6);
        final highlightColor = colorScheme.surfaceContainerHighest;
        return RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [baseColor, highlightColor, baseColor],
                    stops: const [0.3, 0.5, 0.7],
                    transform: _SlidingGradientTransform(slidePercent: _controller.value),
                  ).createShader(bounds);
                },
                child: child,
              );
            },
            child: widget.child,
          ),
        );
      },
    );
  }

  void _syncAnimation(bool shouldAnimate) {
    if (shouldAnimate && !_controller.isAnimating) {
      _controller.repeat();
      return;
    }
    if (!shouldAnimate && _controller.isAnimating) {
      _controller.stop();
    }
  }
}

class AppShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;

  const AppShimmerBox({super.key, this.width, this.height, this.borderRadius = 4});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (slidePercent * 2 - 1), 0, 0);
  }
}
