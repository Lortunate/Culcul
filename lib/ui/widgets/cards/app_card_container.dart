import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/core/perf/performance_policy.dart';
import 'package:flutter/material.dart';

class AppCardContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const AppCardContainer({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius = CulculRadius.lg,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final interactiveChild = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AppClickable(
        onTap: onTap,
        onLongPress: onLongPress,
        haptic: true,
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );

    return RepaintBoundary(
      child: ValueListenableBuilder<PerformancePolicy>(
        valueListenable: PerformancePolicyController.notifier,
        builder: (context, policy, child) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: color ?? theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                switch (policy.level) {
                  RenderDegradeLevel.minimalEffects => BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.02),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                  RenderDegradeLevel.reducedEffects => BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                  RenderDegradeLevel.normal => BoxShadow(
                    color: theme.colorScheme.shadow.withValues(
                      alpha: theme.brightness == Brightness.dark ? 0.3 : 0.08,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                },
              ],
            ),
            child: child,
          );
        },
        child: interactiveChild,
      ),
    );
  }
}
