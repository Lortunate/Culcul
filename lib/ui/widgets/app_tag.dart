import 'package:flutter/material.dart';

class AppTag extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const AppTag({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    this.borderRadius = 4,
  });

  Color _backgroundColor(ColorScheme colorScheme) {
    return color ?? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
  }

  Color _foregroundColor(ColorScheme colorScheme) {
    return textColor ?? colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _backgroundColor(colorScheme),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelSmall?.copyWith(
          color: _foregroundColor(colorScheme),
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

