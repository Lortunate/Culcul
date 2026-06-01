import 'package:dio/dio.dart';

sealed class AppError implements Exception {
  final String message;
  final int? code;
  final Object? cause;

  const AppError(this.message, {this.code, this.cause});

  const factory AppError.network(String message, {int? code, Object? cause}) =
      NetworkAppError;

  const factory AppError.server(String message, {int? code, Object? cause}) =
      ServerAppError;

  const factory AppError.auth(String message, {int? code, Object? cause}) = AuthAppError;

  const factory AppError.data(String message, {int? code, Object? cause}) = DataAppError;

  const factory AppError.cancel(String message, {int? code, Object? cause}) =
      CancelAppError;

  const factory AppError.unknown(String message, {int? code, Object? cause}) =
      UnknownAppError;

  static AppError fromObject(Object error) {
    if (error is AppError) {
      return error;
    }
    if (error is DioException) {
      return _fromDioException(error);
    }
    return AppError.unknown(error.toString(), cause: error);
  }

  static AppError _fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return AppError.network('Network error: ${error.message}', cause: error);
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.statusMessage ?? 'Server error';
        if (statusCode == 401 || statusCode == 403) {
          return AppError.auth(message, code: statusCode, cause: error);
        }
        return AppError.server(message, code: statusCode, cause: error);
      case DioExceptionType.cancel:
        return AppError.cancel('Request cancelled', cause: error);
      case DioExceptionType.badCertificate:
        return AppError.network('Bad certificate', cause: error);
      case DioExceptionType.unknown:
        return AppError.unknown('Unknown error: ${error.message}', cause: error);
    }
  }

  @override
  String toString() {
    if (code != null) {
      return '$runtimeType: [$code] $message';
    }
    return '$runtimeType: $message';
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
