import 'package:culcul/core/errors/error_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_selectable_text.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final Object? error;
  final StackTrace? stackTrace;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const AppErrorWidget({
    super.key,
    this.error,
    this.stackTrace,
    this.message,
    this.onRetry,
    this.icon,
  });

  String _resolveDisplayMessage(BuildContext context) {
    final t = Translations.of(context);
    return message ??
        (error != null ? ErrorHandler.getErrorMessage(context, error) : t.common.error);
  }

  Future<void> _showErrorDetails(BuildContext context) {
    final t = Translations.of(context);

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.error.details),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${t.common.error}: $error',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (stackTrace != null) ...[
                const SizedBox(height: 8),
                Text(
                  '${t.error.stack_trace}:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                AppSelectableText(
                  stackTrace.toString(),
                  style: const TextStyle(fontSize: 10, fontFamily: 'Courier'),
                ),
              ],
            ],
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
    final displayMessage = _resolveDisplayMessage(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline_rounded,
              size: 56,
              color: colorScheme.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text(
              displayMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              _ErrorDetailsButton(onPressed: () => _showErrorDetails(context)),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              _RetryButton(
                label: t.common.retry,
                onPressed: onRetry!,
                borderColor: colorScheme.outlineVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ErrorDetailsButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Text(t.error.view_details, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color borderColor;

  const _RetryButton({
    required this.label,
    required this.onPressed,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh_rounded, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
