import 'package:culcul/core/errors/app_error.dart';
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

  group('AppError.fromObject with DioException', () {
    RequestOptions opts() => RequestOptions(path: '/api');

    test('connectionTimeout returns NetworkAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.connectionTimeout,
          message: 'timed out',
        ),
      );

      expect(result, isA<NetworkAppError>());
      expect(result.message, contains('timed out'));
    });

    test('sendTimeout returns NetworkAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.sendTimeout,
          message: 'send timeout',
        ),
      );

      expect(result, isA<NetworkAppError>());
    });

    test('receiveTimeout returns NetworkAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.receiveTimeout,
          message: 'receive timeout',
        ),
      );

      expect(result, isA<NetworkAppError>());
    });

    test('connectionError returns NetworkAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.connectionError,
          message: 'connection failed',
        ),
      );

      expect(result, isA<NetworkAppError>());
    });

    test('badResponse 401 returns AuthAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: opts(),
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
        ),
      );

      expect(result, isA<AuthAppError>());
      expect(result.code, 401);
      expect(result.message, 'Unauthorized');
    });

    test('badResponse 403 returns AuthAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: opts(),
            statusCode: 403,
            statusMessage: 'Forbidden',
          ),
        ),
      );

      expect(result, isA<AuthAppError>());
      expect(result.code, 403);
    });

    test('badResponse 500 returns ServerAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: opts(),
            statusCode: 500,
            statusMessage: 'Internal Server Error',
          ),
        ),
      );

      expect(result, isA<ServerAppError>());
      expect(result.code, 500);
      expect(result.message, 'Internal Server Error');
    });

    test('badResponse with null statusMessage defaults to Server error', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: opts(), statusCode: 502),
        ),
      );

      expect(result, isA<ServerAppError>());
      expect(result.message, 'Server error');
    });

    test('badResponse with null statusCode passes null code', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: opts()),
        ),
      );

      expect(result, isA<ServerAppError>());
      expect(result.code, isNull);
    });

    test('cancel returns CancelAppError', () {
      final result = AppError.fromObject(
        DioException(requestOptions: opts(), type: DioExceptionType.cancel),
      );

      expect(result, isA<CancelAppError>());
      expect(result.message, 'Request cancelled');
    });

    test('badCertificate returns NetworkAppError', () {
      final result = AppError.fromObject(
        DioException(requestOptions: opts(), type: DioExceptionType.badCertificate),
      );

      expect(result, isA<NetworkAppError>());
      expect(result.message, 'Bad certificate');
    });

    test('unknown returns UnknownAppError', () {
      final result = AppError.fromObject(
        DioException(
          requestOptions: opts(),
          type: DioExceptionType.unknown,
          message: 'weird failure',
        ),
      );

      expect(result, isA<UnknownAppError>());
      expect(result.message, contains('weird failure'));
    });

    test('original DioException is stored as cause', () {
      final dioError = DioException(
        requestOptions: opts(),
        type: DioExceptionType.connectionTimeout,
      );

      final result = AppError.fromObject(dioError);

      expect(result.cause, same(dioError));
    });
  });

  group('AppError.fromObject with AppException', () {
    test('NetworkException returns NetworkAppError', () {
      final result = AppError.fromObject(
        const NetworkException('no internet', code: 503),
      );

      expect(result, isA<NetworkAppError>());
      expect(result.message, 'no internet');
      expect(result.code, 503);
    });

    test('AuthException returns AuthAppError', () {
      final result = AppError.fromObject(const AuthException('unauthorized', code: 401));

      expect(result, isA<AuthAppError>());
      expect(result.message, 'unauthorized');
      expect(result.code, 401);
    });

    test('UnknownException returns UnknownAppError', () {
      final result = AppError.fromObject(const UnknownException('something broke'));

      expect(result, isA<UnknownAppError>());
      expect(result.message, 'something broke');
    });
  });
}
