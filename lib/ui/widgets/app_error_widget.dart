import 'package:culcul/core/errors/error_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    final displayMessage =
        message ??
        (error != null
            ? ErrorHandler.getErrorMessage(context, error)
            : t.common.error);

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
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error Details'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Error: $error',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            if (stackTrace != null) ...[
                              const SizedBox(height: 8),
                              const Text(
                                'Stack Trace:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              SelectableText(
                                stackTrace.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Courier',
                                ),
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
                },
                child: const Text('View Details', style: TextStyle(fontSize: 12)),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(t.common.retry),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colorScheme.outlineVariant),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
