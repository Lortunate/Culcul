import 'package:culcul/ui/widgets/app_clickable.dart';
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

  BoxShadow _buildShadow(Brightness brightness) {
    return BoxShadow(
      color: Colors.black.withValues(
        alpha: brightness == Brightness.dark ? 0.2 : 0.05,
      ),
      blurRadius: 10,
      offset: const Offset(0, 4),
    );
  }

  BoxDecoration _buildDecoration(ThemeData theme) {
    return BoxDecoration(
      color: color ?? theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [_buildShadow(theme.brightness)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RepaintBoundary(
      child: Container(
        decoration: _buildDecoration(theme),
        child: AppClickable(
          onTap: onTap,
          onLongPress: onLongPress,
          haptic: true,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ),
      ),
    );
  }
}
