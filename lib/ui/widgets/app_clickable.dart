import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool haptic;

  @Deprecated('请在外部或 child 中自行处理 borderRadius')
  final BorderRadius? borderRadius;

  @Deprecated('请在外部或 child 中自行处理 backgroundColor')
  final Color? backgroundColor;

  @Deprecated('请在外部或 child 内部使用 Padding 处理')
  final EdgeInsetsGeometry? padding;

  @Deprecated('请在外部使用 Container/Padding 处理 margin')
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
    Widget content = InkWell(
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
      borderRadius: borderRadius, // 兼容旧代码，避免水波纹溢出圆角
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
