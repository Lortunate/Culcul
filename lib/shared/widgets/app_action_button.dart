import 'package:flutter/material.dart';

class AppActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final double iconSize;
  final double fontSize;
  final bool active;
  final Color? activeColor;

  const AppActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
    this.iconSize = 24.0,
    this.fontSize = 11.0,
    this.active = false,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveActiveColor = activeColor ?? theme.primaryColor;
    final defaultColor = isDark ? Colors.white70 : Colors.black54;
    final effectiveColor = active
        ? effectiveActiveColor
        : (color ?? defaultColor);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: effectiveColor),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  color: effectiveColor,
                  fontWeight: active ? FontWeight.bold : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
