import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final int? code;
  final dynamic cause;

  const AppException(this.message, {this.code, this.cause});

  @override
  String toString() {
    if (code != null) {
      return '$runtimeType: [$code] $message';
    }
    return '$runtimeType: $message';
  }
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.cause});
}

class ServerException extends AppException {
  const ServerException(super.message, {super.code, super.cause});
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.cause});
}

class DataException extends AppException {
  const DataException(super.message, {super.code, super.cause});
}

class UnknownException extends AppException {
  const UnknownException(super.message, {super.code, super.cause});
}

class CancelException extends AppException {
  const CancelException(super.message, {super.code, super.cause});
}

AppException dioExceptionToAppException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return NetworkException('Network error: ${e.message}', cause: e);
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final message = e.response?.statusMessage ?? 'Server error';

      if (statusCode == 401 || statusCode == 403) {
        return AuthException(message, code: statusCode, cause: e);
      }
      return ServerException(message, code: statusCode, cause: e);
    case DioExceptionType.cancel:
      return CancelException('Request cancelled', cause: e);
    case DioExceptionType.badCertificate:
      return NetworkException('Bad certificate', cause: e);
    case DioExceptionType.unknown:
      return UnknownException('Unknown error: ${e.message}', cause: e);
  }
}
