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
