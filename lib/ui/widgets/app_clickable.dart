import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A unified clickable widget that provides consistent inkwell feedback.
/// Wraps [InkWell] with [Material] to ensure the ripple effect works correctly
/// even when the child has its own background color.
class AppClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AppClickable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.haptic = false,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: borderRadius != null ? Clip.antiAlias : Clip.none,
        child: InkWell(
          onTap: onTap != null
              ? () {
                  if (haptic) HapticFeedback.lightImpact();
                  onTap?.call();
                }
              : null,
          onLongPress: onLongPress != null
              ? () {
                  if (haptic) HapticFeedback.mediumImpact();
                  onLongPress?.call();
                }
              : null,
          borderRadius: borderRadius,
          child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
        ),
      ),
    );
  }
}
