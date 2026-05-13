import 'package:culcul/core/errors/error_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum AppFeedbackLevel { info, error }

extension AppFeedbackContext on BuildContext {
  void showAppFeedback(
    String message, {
    AppFeedbackLevel level = AppFeedbackLevel.info,
    Duration? duration,
    bool hideCurrent = false,
  }) {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(this);
    if (hideCurrent) {
      messenger.hideCurrentSnackBar();
    }

    final theme = Theme.of(this);
    final isError = level == AppFeedbackLevel.error;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: isError ? TextStyle(color: theme.colorScheme.onError) : null,
        ),
        backgroundColor: isError ? theme.colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? Duration(milliseconds: isError ? 3000 : 2000),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void showAppError(Object error, {VoidCallback? onRetry}) {
    if (!mounted) return;

    final message = ErrorHandler.getErrorMessage(this, error);
    final theme = Theme.of(this);
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: theme.colorScheme.onError)),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: onRetry != null
            ? SnackBarAction(
                label: Translations.of(this).common.retry,
                textColor: theme.colorScheme.onErrorContainer,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }
}

