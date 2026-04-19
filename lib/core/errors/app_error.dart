import 'package:culcul/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

sealed class AppError {
  final String message;
  final int? code;
  final Object? cause;

  const AppError(this.message, {this.code, this.cause});

  static AppError _fromException(AppException exception) {
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
      return _fromException(error);
    }
    if (error is DioException) {
      return _fromDioException(error);
    }
    return UnknownAppError(error.toString(), cause: error);
  }

  static AppError _fromDioException(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError => NetworkAppError(
        'Network error: ${error.message}',
        cause: error,
      ),
      DioExceptionType.badResponse => _fromBadResponse(error),
      DioExceptionType.cancel => CancelAppError('Request cancelled', cause: error),
      DioExceptionType.badCertificate => NetworkAppError('Bad certificate', cause: error),
      DioExceptionType.unknown => UnknownAppError(
        'Unknown error: ${error.message}',
        cause: error,
      ),
    };
  }

  static AppError _fromBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.statusMessage ?? 'Server error';
    if (statusCode == 401 || statusCode == 403) {
      return AuthAppError(message, code: statusCode, cause: error);
    }
    return ServerAppError(message, code: statusCode, cause: error);
  }

  static AppError network(String message, {int? code, Object? cause}) {
    return NetworkAppError(message, code: code, cause: cause);
  }

  static AppError server(String message, {int? code, Object? cause}) {
    return ServerAppError(message, code: code, cause: cause);
  }

  static AppError auth(String message, {int? code, Object? cause}) {
    return AuthAppError(message, code: code, cause: cause);
  }

  static AppError data(String message, {int? code, Object? cause}) {
    return DataAppError(message, code: code, cause: cause);
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
