import 'package:culcul/core/errors/error_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/inputs/app_selectable_text.dart';
import 'package:flutter/material.dart';

enum AppErrorWidgetVariant { regular, compact }

class AppErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback onRetry;
  final IconData? icon;
  final bool compact;
  final AppErrorWidgetVariant variant;

  const AppErrorWidget({
    super.key,
    required this.error,
    this.stackTrace,
    required this.onRetry,
    this.icon,
    this.compact = false,
    this.variant = AppErrorWidgetVariant.regular,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isCompact = compact || variant == AppErrorWidgetVariant.compact;
    final displayMessage = ErrorHandler.getShortErrorMessage(context, error);
    ErrorHandler.logError(error, stackTrace: stackTrace);

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(isCompact ? CulculSpacing.md : CulculSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline_rounded,
              size: isCompact ? 32 : 56,
              color: colorScheme.error.withValues(alpha: 0.7),
            ),
            SizedBox(height: isCompact ? CulculSpacing.sm : CulculSpacing.md),
            Text(
              displayMessage,
              textAlign: TextAlign.center,
              maxLines: isCompact ? 2 : 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: isCompact ? CulculSpacing.sm : CulculSpacing.md),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: isCompact ? CulculSpacing.xs : CulculSpacing.sm,
              runSpacing: CulculSpacing.xs,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    final details = ErrorHandler.buildErrorDetails(
                      context,
                      error,
                      stackTrace: stackTrace,
                    );

                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text(t.error.details),
                        content: SingleChildScrollView(
                          child: AppSelectableText(
                            details,
                            style: const TextStyle(fontSize: 12, fontFamily: 'Courier'),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: Text(t.common.confirm),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline_rounded, size: 16),
                  label: Text(
                    t.error.view_details,
                    style: TextStyle(fontSize: isCompact ? 11 : 13),
                  ),
                  style: OutlinedButton.styleFrom(
                    visualDensity: isCompact
                        ? VisualDensity.compact
                        : VisualDensity.standard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CulculRadius.lg),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: Icon(Icons.refresh_rounded, size: isCompact ? 16 : 18),
                  label: Text(t.common.retry),
                  style: OutlinedButton.styleFrom(
                    visualDensity: isCompact
                        ? VisualDensity.compact
                        : VisualDensity.standard,
                    side: BorderSide(color: colorScheme.outlineVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CulculRadius.lg),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isCompact ? CulculSpacing.sm : CulculSpacing.lg,
                      vertical: isCompact ? CulculSpacing.xs : CulculSpacing.sm,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
