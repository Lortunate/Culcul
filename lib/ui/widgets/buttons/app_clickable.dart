import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;
  final String? semanticsLabel;

  const AppClickable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.haptic = false,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final tapHandler = onTap == null
        ? null
        : () {
            if (haptic) {
              HapticFeedback.lightImpact();
            }
            onTap?.call();
          };
    final longPressHandler = onLongPress == null
        ? null
        : () {
            if (haptic) {
              HapticFeedback.mediumImpact();
            }
            onLongPress?.call();
          };

    final widget = InkWell(
      onTap: tapHandler,
      onLongPress: longPressHandler,
      child: child,
    );

    if (semanticsLabel != null) {
      return Semantics(
        label: semanticsLabel,
        button: true,
        enabled: onTap != null,
        child: widget,
      );
    }
    return widget;
  }
}
