import 'package:culcul/core/errors/error_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_selectable_text.dart';
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

  Future<void> _showErrorDetails(BuildContext context) {
    final t = Translations.of(context);
    final details = ErrorHandler.buildErrorDetails(
      context,
      error,
      stackTrace: stackTrace,
    );

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.error.details),
        content: SingleChildScrollView(
          child: AppSelectableText(
            details,
            style: const TextStyle(fontSize: 12, fontFamily: 'Courier'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.common.confirm),
          ),
        ],
      ),
    );
  }

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
        padding: EdgeInsets.all(isCompact ? 16.0 : 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline_rounded,
              size: isCompact ? 32 : 56,
              color: colorScheme.error.withValues(alpha: 0.7),
            ),
            SizedBox(height: isCompact ? 12 : 16),
            Text(
              displayMessage,
              textAlign: TextAlign.center,
              maxLines: isCompact ? 2 : 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: isCompact ? 12 : 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: isCompact ? 8 : 12,
              runSpacing: 8,
              children: [
                _ErrorDetailsButton(
                  onPressed: () => _showErrorDetails(context),
                  compact: isCompact,
                ),
                _RetryButton(
                  label: t.common.retry,
                  onPressed: onRetry,
                  borderColor: colorScheme.outlineVariant,
                  compact: isCompact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool compact;

  const _ErrorDetailsButton({required this.onPressed, required this.compact});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.info_outline_rounded, size: 16),
      label: Text(t.error.view_details, style: TextStyle(fontSize: compact ? 11 : 13)),
      style: OutlinedButton.styleFrom(
        visualDensity: compact ? VisualDensity.compact : VisualDensity.standard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color borderColor;
  final bool compact;

  const _RetryButton({
    required this.label,
    required this.onPressed,
    required this.borderColor,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.refresh_rounded, size: compact ? 16 : 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        visualDensity: compact ? VisualDensity.compact : VisualDensity.standard,
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 24,
          vertical: compact ? 8 : 12,
        ),
      ),
    );
  }
}
