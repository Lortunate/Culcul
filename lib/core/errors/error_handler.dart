import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static final Set<String> _loggedErrorSignatures = <String>{};

  static String getErrorMessage(BuildContext context, dynamic error) {
    final t = Translations.of(context);
    final rawError = error is Object ? error : StateError('Unknown null error');
    final appError = rawError is AppError ? rawError : AppError.fromObject(rawError);

    return switch (appError) {
      NetworkAppError _ => t.error.network,
      AuthAppError _ => t.error.auth_failed,
      ServerAppError _ =>
        appError.code != null
            ? t.error.bad_response(code: appError.code!)
            : t.error.server_error,
      CancelAppError _ => t.error.cancel,
      DataAppError _ || UnknownAppError _ => appError.message,
    };
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

    DevLogger.log('error', 'app_error', <String, Object?>{
      'source': source,
      'signature': signature,
    });
    if (stackTrace != null) {
      DevLogger.log('error', 'app_error.stack', <String, Object?>{
        'source': source,
        'stack': stackTrace,
      });
    }
  }

  @visibleForTesting
  static void resetLoggedErrorsForTest() {
    _loggedErrorSignatures.clear();
  }

  @visibleForTesting
  static int get loggedErrorCountForTest => _loggedErrorSignatures.length;
}
