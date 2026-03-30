import 'package:culcul/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

sealed class AppError {
  final String message;
  final int? code;
  final Object? cause;

  const AppError(this.message, {this.code, this.cause});

  AppException toException() {
    return switch (this) {
      NetworkAppError _ => NetworkException(message, code: code, cause: cause),
      ServerAppError _ => ServerException(message, code: code, cause: cause),
      AuthAppError _ => AuthException(message, code: code, cause: cause),
      DataAppError _ => DataException(message, code: code, cause: cause),
      CancelAppError _ => CancelException(message, code: code, cause: cause),
      UnknownAppError _ => UnknownException(message, code: code, cause: cause),
    };
  }

  static AppError fromException(AppException exception) {
    if (exception is NetworkException) {
      return NetworkAppError(
        exception.message,
        code: exception.code,
        cause: exception.cause,
      );
    }
    if (exception is ServerException) {
      return ServerAppError(
        exception.message,
        code: exception.code,
        cause: exception.cause,
      );
    }
    if (exception is AuthException) {
      return AuthAppError(
        exception.message,
        code: exception.code,
        cause: exception.cause,
      );
    }
    if (exception is DataException) {
      return DataAppError(
        exception.message,
        code: exception.code,
        cause: exception.cause,
      );
    }
    if (exception is CancelException) {
      return CancelAppError(
        exception.message,
        code: exception.code,
        cause: exception.cause,
      );
    }
    return UnknownAppError(
      exception.message,
      code: exception.code,
      cause: exception.cause,
    );
  }

  static AppError fromObject(Object error) {
    if (error is AppException) {
      return fromException(error);
    }
    if (error is DioException) {
      return fromException(dioExceptionToAppException(error));
    }
    return UnknownAppError('Unexpected error occurred: $error', cause: error);
  }
}

final class NetworkAppError extends AppError {
  const NetworkAppError(super.message, {super.code, super.cause});
}

final class ServerAppError extends AppError {
  const ServerAppError(super.message, {super.code, super.cause});
}

final class AuthAppError extends AppError {
  const AuthAppError(super.message, {super.code, super.cause});
}

final class DataAppError extends AppError {
  const DataAppError(super.message, {super.code, super.cause});
}

final class CancelAppError extends AppError {
  const CancelAppError(super.message, {super.code, super.cause});
}

final class UnknownAppError extends AppError {
  const UnknownAppError(super.message, {super.code, super.cause});
}
