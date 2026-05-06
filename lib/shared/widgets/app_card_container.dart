import 'package:culcul/shared/widgets/app_clickable.dart';
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
    this.borderRadius = 8,
    this.padding,
    this.color,
  });

  BoxShadow _buildShadow(ThemeData theme, PerformancePolicy policy) {
    if (policy.level == RenderDegradeLevel.minimalEffects) {
      return BoxShadow(
        color: theme.colorScheme.shadow.withValues(alpha: 0.02),
        blurRadius: 3,
        offset: const Offset(0, 1),
      );
    }
    if (policy.level == RenderDegradeLevel.reducedEffects) {
      return BoxShadow(
        color: theme.colorScheme.shadow.withValues(alpha: 0.05),
        blurRadius: 6,
        offset: const Offset(0, 2),
      );
    }
    return BoxShadow(
      color: theme.colorScheme.shadow.withValues(
        alpha: theme.brightness == Brightness.dark ? 0.3 : 0.08,
      ),
      blurRadius: 10,
      offset: const Offset(0, 4),
    );
  }

  BoxDecoration _buildDecoration(ThemeData theme, PerformancePolicy policy) {
    return BoxDecoration(
      color: color ?? theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [_buildShadow(theme, policy)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final interactiveChild = AppClickable(
      onTap: onTap,
      onLongPress: onLongPress,
      haptic: true,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );

    return RepaintBoundary(
      child: ValueListenableBuilder<PerformancePolicy>(
        valueListenable: PerformancePolicyController.notifier,
        builder: (context, policy, child) {
          return DecoratedBox(decoration: _buildDecoration(theme, policy), child: child);
        },
        child: interactiveChild,
      ),
    );
  }
}
