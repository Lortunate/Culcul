import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;

  const AppClickable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.haptic = false,
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
    return InkWell(
      onTap: _buildTapHandler(),
      onLongPress: _buildLongPressHandler(),
      child: child,
    );
  }
}
