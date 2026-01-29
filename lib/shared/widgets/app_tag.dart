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
    this.borderRadius = 3,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBgColor = isDark
        ? Colors.white.withOpacity(0.1)
        : Colors.black.withOpacity(0.05);

    final defaultTextColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? defaultBgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? defaultTextColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
