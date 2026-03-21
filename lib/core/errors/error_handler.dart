import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static String getErrorMessage(BuildContext context, dynamic error) {
    final t = Translations.of(context);

    if (error is NetworkException) {
      return t.error.network;
    } else if (error is AuthException) {
      return 'Authentication failed';
    } else if (error is ServerException) {
      if (error.code != null) {
        return t.error.bad_response(code: error.code!);
      }
      return 'Server error';
    } else if (error is CancelException) {
      return t.error.cancel;
    } else if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }

  static void showErrorSnackBar(
    BuildContext context,
    dynamic error, {
    VoidCallback? onRetry,
  }) {
    final message = getErrorMessage(context, error);
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: theme.colorScheme.onError)),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: onRetry != null
            ? SnackBarAction(
                label: Translations.of(context).common.retry,
                textColor: theme.colorScheme.onErrorContainer,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }
}
