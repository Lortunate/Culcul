import 'package:culcul/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('exception creation', () {
    test('NetworkException stores message and code', () {
      final e = const NetworkException('no internet', code: 503);

      expect(e.message, 'no internet');
      expect(e.code, 503);
    });

    test('ServerException stores message and code', () {
      final e = const ServerException('internal error', code: 500);

      expect(e.message, 'internal error');
      expect(e.code, 500);
    });

    test('AuthException stores message and code', () {
      final e = const AuthException('unauthorized', code: 401);

      expect(e.message, 'unauthorized');
      expect(e.code, 401);
    });

    test('DataException stores message and code', () {
      final e = const DataException('parse failed', code: 422);

      expect(e.message, 'parse failed');
      expect(e.code, 422);
    });

    test('CancelException stores message', () {
      final e = const CancelException('cancelled');

      expect(e.message, 'cancelled');
      expect(e.code, isNull);
    });

    test('UnknownException stores message and code', () {
      final e = const UnknownException('something broke', code: -1);

      expect(e.message, 'something broke');
      expect(e.code, -1);
    });
  });

  group('exception cause', () {
    test('cause is stored when provided', () {
      final cause = Exception('root');
      final e = NetworkException('wrapper', cause: cause);

      expect(e.cause, same(cause));
    });

    test('cause is null by default', () {
      final e = const ServerException('no cause');

      expect(e.cause, isNull);
    });
  });

  group('AppException.toString', () {
    test('includes code when present', () {
      final e = const ServerException('bad gateway', code: 502);

      expect(e.toString(), 'ServerException: [502] bad gateway');
    });

    test('omits code when null', () {
      final e = const NetworkException('timeout');

      expect(e.toString(), 'NetworkException: timeout');
    });
  });

  group('dioExceptionToAppException', () {
    RequestOptions _opts() => RequestOptions(path: '/api');

    test('connectionTimeout returns NetworkException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.connectionTimeout,
          message: 'timed out',
        ),
      );

      expect(result, isA<NetworkException>());
      expect(result.message, contains('timed out'));
    });

    test('sendTimeout returns NetworkException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.sendTimeout,
          message: 'send timeout',
        ),
      );

      expect(result, isA<NetworkException>());
    });

    test('receiveTimeout returns NetworkException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.receiveTimeout,
          message: 'receive timeout',
        ),
      );

      expect(result, isA<NetworkException>());
    });

    test('connectionError returns NetworkException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.connectionError,
          message: 'connection failed',
        ),
      );

      expect(result, isA<NetworkException>());
    });

    test('badResponse 401 returns AuthException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: _opts(),
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
        ),
      );

      expect(result, isA<AuthException>());
      expect(result.code, 401);
      expect(result.message, 'Unauthorized');
    });

    test('badResponse 403 returns AuthException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: _opts(),
            statusCode: 403,
            statusMessage: 'Forbidden',
          ),
        ),
      );

      expect(result, isA<AuthException>());
      expect(result.code, 403);
    });

    test('badResponse 500 returns ServerException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: _opts(),
            statusCode: 500,
            statusMessage: 'Internal Server Error',
          ),
        ),
      );

      expect(result, isA<ServerException>());
      expect(result.code, 500);
      expect(result.message, 'Internal Server Error');
    });

    test('badResponse with null statusMessage defaults to Server error', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: _opts(), statusCode: 502),
        ),
      );

      expect(result, isA<ServerException>());
      expect(result.message, 'Server error');
    });

    test('badResponse with null statusCode passes null code', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: _opts()),
        ),
      );

      expect(result, isA<ServerException>());
      expect(result.code, isNull);
    });

    test('cancel returns CancelException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.cancel,
        ),
      );

      expect(result, isA<CancelException>());
      expect(result.message, 'Request cancelled');
    });

    test('badCertificate returns NetworkException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.badCertificate,
        ),
      );

      expect(result, isA<NetworkException>());
      expect(result.message, 'Bad certificate');
    });

    test('unknown returns UnknownException', () {
      final result = dioExceptionToAppException(
        DioException(
          requestOptions: _opts(),
          type: DioExceptionType.unknown,
          message: 'weird failure',
        ),
      );

      expect(result, isA<UnknownException>());
      expect(result.message, contains('weird failure'));
    });

    test('original DioException is stored as cause', () {
      final dioError = DioException(
        requestOptions: _opts(),
        type: DioExceptionType.connectionTimeout,
      );

      final result = dioExceptionToAppException(dioError);

      expect(result.cause, same(dioError));
    });
  });
}
