import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String? value;
  final VoidCallback? onTap;
  final bool showArrow;
  final Widget? trailing;

  const SettingsItem({
    super.key,
    required this.title,
    this.value,
    this.onTap,
    this.showArrow = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else ...[
              if (value != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    value!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ),
              if (showArrow) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: colorScheme.outline,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
