import 'package:culcul/shared/widgets/app_clickable.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.icon,
    this.trailing,
    this.onTap,
    this.showArrow = true,
  });

  final String title;
  final String? subtitle;
  final String? value;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget child = Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (value != null)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                value!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: trailing!,
            )
          else if (showArrow && onTap != null) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      child = AppClickable(
        onTap: onTap,
        child: child,
      );
    }

    return child;
  }
}
