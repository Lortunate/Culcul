import 'package:culcul/ui/widgets/app_clickable.dart';
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
    final colorScheme = theme.colorScheme;

    final effectiveActiveColor = activeColor ?? colorScheme.primary;
    final effectiveColor = active
        ? effectiveActiveColor
        : (color ?? colorScheme.onSurfaceVariant);

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
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
              style: theme.textTheme.labelSmall?.copyWith(
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
    );
  }
}
