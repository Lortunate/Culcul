import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static final Set<String> _loggedErrorSignatures = <String>{};

  static String getErrorMessage(BuildContext context, dynamic error) {
    final t = Translations.of(context);

    if (error is AppError) {
      return switch (error) {
        NetworkAppError _ => t.error.network,
        AuthAppError _ => t.error.auth_failed,
        ServerAppError _ =>
          error.code != null
              ? t.error.bad_response(code: error.code!)
              : t.error.server_error,
        CancelAppError _ => t.error.cancel,
        DataAppError _ || UnknownAppError _ => error.message,
      };
    }

    if (error is NetworkException) {
      return t.error.network;
    } else if (error is AuthException) {
      return t.error.auth_failed;
    } else if (error is ServerException) {
      if (error.code != null) {
        return t.error.bad_response(code: error.code!);
      }
      return t.error.server_error;
    } else if (error is CancelException) {
      return t.error.cancel;
    } else if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }

  static String getShortErrorMessage(
    BuildContext context,
    Object error, {
    int maxLength = 120,
  }) {
    final fallback = Translations.of(context).common.error;
    final full = getErrorMessage(context, error).trim();
    if (full.isEmpty) return fallback;

    final firstLine = full.split(RegExp(r'\r?\n')).first.trim();
    if (firstLine.isEmpty) return fallback;
    if (firstLine.length <= maxLength) return firstLine;
    if (maxLength <= 3) return firstLine.substring(0, maxLength);
    return '${firstLine.substring(0, maxLength - 3)}...';
  }

  static String buildErrorDetails(
    BuildContext context,
    Object error, {
    StackTrace? stackTrace,
  }) {
    final t = Translations.of(context);
    final mappedMessage = getErrorMessage(context, error);
    final details = StringBuffer()
      ..writeln('${t.common.error}: $mappedMessage')
      ..writeln('Type: ${error.runtimeType}')
      ..writeln('Raw: $error');

    if (stackTrace != null) {
      details
        ..writeln()
        ..writeln('${t.error.stack_trace}:')
        ..writeln(stackTrace);
    }

    return details.toString().trimRight();
  }

  static void logError(
    Object error, {
    StackTrace? stackTrace,
    String source = 'AppErrorWidget',
  }) {
    final signature = '${error.runtimeType}|$error';
    if (!_loggedErrorSignatures.add(signature)) return;

    debugPrint('[$source] $signature');
    if (stackTrace != null) {
      debugPrint('[$source][stack]\n$stackTrace');
    }
  }

  @visibleForTesting
  static void resetLoggedErrorsForTest() {
    _loggedErrorSignatures.clear();
  }

  @visibleForTesting
  static int get loggedErrorCountForTest => _loggedErrorSignatures.length;

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
