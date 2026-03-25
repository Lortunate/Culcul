import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;

  @Deprecated('Handle borderRadius outside this widget or in child.')
  final BorderRadius? borderRadius;

  @Deprecated('Handle backgroundColor outside this widget or in child.')
  final Color? backgroundColor;

  @Deprecated('Use Padding outside this widget or inside child.')
  final EdgeInsetsGeometry? padding;

  @Deprecated('Use Container/Padding outside this widget for margin.')
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

  VoidCallback? _buildTapHandler() {
    if (onTap == null) {
      return null;
    }

    return () {
      if (haptic) {
        HapticFeedback.lightImpact();
      }
      onTap?.call();
    };
  }

  VoidCallback? _buildLongPressHandler() {
    if (onLongPress == null) {
      return null;
    }

    return () {
      if (haptic) {
        HapticFeedback.mediumImpact();
      }
      onLongPress?.call();
    };
  }

  @override
  Widget build(BuildContext context) {
    Widget content = InkWell(
      onTap: _buildTapHandler(),
      onLongPress: _buildLongPressHandler(),
      borderRadius: borderRadius,
      child: padding != null && padding != EdgeInsets.zero
          ? Padding(padding: padding!, child: child)
          : child,
    );

    if (backgroundColor != null || borderRadius != null) {
      content = Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: borderRadius != null ? Clip.antiAlias : Clip.none,
        child: content,
      );
    }

    if (margin != null && margin != EdgeInsets.zero) {
      content = Container(margin: margin, child: content);
    }

    return content;
  }
}

