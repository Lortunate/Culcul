import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final double fontSize;
  final Color? color;
  final TextStyle? style;
  final double spacing;

  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 14,
    this.fontSize = 11,
    this.color,
    this.style,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor =
        color ?? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
    final effectiveStyle =
        style ??
        theme.textTheme.labelSmall?.copyWith(color: effectiveColor, fontSize: fontSize);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: effectiveColor),
        SizedBox(width: spacing),
        Text(text, style: effectiveStyle),
      ],
    );
  }
}
