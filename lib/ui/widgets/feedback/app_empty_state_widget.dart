import 'package:flutter/material.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';

class AppEmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;
  final bool compact;

  const AppEmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(compact ? CulculSpacing.md : CulculSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: compact ? 36 : 56, color: colorScheme.outline),
            SizedBox(height: compact ? CulculSpacing.sm : CulculSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: compact ? 2 : 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            if (onAction != null && actionLabel != null) ...[
              SizedBox(height: compact ? CulculSpacing.sm : CulculSpacing.md),
              OutlinedButton(
                onPressed: onAction,
                style: OutlinedButton.styleFrom(
                  visualDensity: compact ? VisualDensity.compact : VisualDensity.standard,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(CulculRadius.lg),
                  ),
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
