import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;

  const AppSearchBar({
    super.key,
    this.onTap,
    this.hintText = 'Search videos...',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: theme.inputDecorationTheme.fillColor ??
              colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hintText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
