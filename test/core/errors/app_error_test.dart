import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppError.fromObject', () {
    test('NetworkException maps to NetworkAppError', () {
      final error = AppError.fromObject(const NetworkException('no internet', code: 503));

      expect(error, isA<NetworkAppError>());
      expect(error.message, 'no internet');
      expect(error.code, 503);
    });

    test('ServerException maps to ServerAppError', () {
      final error = AppError.fromObject(
        const ServerException('internal error', code: 500),
      );

      expect(error, isA<ServerAppError>());
      expect(error.message, 'internal error');
      expect(error.code, 500);
    });

    test('AuthException maps to AuthAppError', () {
      final error = AppError.fromObject(const AuthException('unauthorized', code: 401));

      expect(error, isA<AuthAppError>());
      expect(error.message, 'unauthorized');
      expect(error.code, 401);
    });

    test('DataException maps to DataAppError', () {
      final error = AppError.fromObject(const DataException('parse failed', code: 422));

      expect(error, isA<DataAppError>());
      expect(error.message, 'parse failed');
      expect(error.code, 422);
    });

    test('CancelException maps to CancelAppError', () {
      final error = AppError.fromObject(const CancelException('cancelled'));

      expect(error, isA<CancelAppError>());
      expect(error.message, 'cancelled');
    });

    test('UnknownException maps to UnknownAppError', () {
      final error = AppError.fromObject(const UnknownException('something broke'));

      expect(error, isA<UnknownAppError>());
      expect(error.message, 'something broke');
    });

    test('plain object maps to UnknownAppError with toString', () {
      final error = AppError.fromObject(ArgumentError('bad arg'));

      expect(error, isA<UnknownAppError>());
      expect(error.message, contains('bad arg'));
      expect(error.cause, isA<ArgumentError>());
    });
  });

  group('AppError.fromObject with DioException', () {
    RequestOptions requestOptions() => RequestOptions(path: '/test');

    test('connectionTimeout maps to NetworkAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.connectionTimeout,
          message: 'timed out',
        ),
      );

      expect(error, isA<NetworkAppError>());
      expect(error.message, contains('timed out'));
    });

    test('sendTimeout maps to NetworkAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.sendTimeout,
        ),
      );

      expect(error, isA<NetworkAppError>());
    });

    test('receiveTimeout maps to NetworkAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      expect(error, isA<NetworkAppError>());
    });

    test('connectionError maps to NetworkAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(error, isA<NetworkAppError>());
    });

    test('badResponse 401 maps to AuthAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions(),
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
        ),
      );

      expect(error, isA<AuthAppError>());
      expect(error.code, 401);
      expect(error.message, 'Unauthorized');
    });

    test('badResponse 403 maps to AuthAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions(),
            statusCode: 403,
            statusMessage: 'Forbidden',
          ),
        ),
      );

      expect(error, isA<AuthAppError>());
      expect(error.code, 403);
    });

    test('badResponse 500 maps to ServerAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions(),
            statusCode: 500,
            statusMessage: 'Internal Server Error',
          ),
        ),
      );

      expect(error, isA<ServerAppError>());
      expect(error.code, 500);
      expect(error.message, 'Internal Server Error');
    });

    test('badResponse with null statusMessage defaults to Server error', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: requestOptions(), statusCode: 502),
        ),
      );

      expect(error, isA<ServerAppError>());
      expect(error.message, 'Server error');
    });

    test('cancel maps to CancelAppError', () {
      final error = AppError.fromObject(
        DioException(requestOptions: requestOptions(), type: DioExceptionType.cancel),
      );

      expect(error, isA<CancelAppError>());
      expect(error.message, 'Request cancelled');
    });

    test('badCertificate maps to NetworkAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.badCertificate,
        ),
      );

      expect(error, isA<NetworkAppError>());
      expect(error.message, 'Bad certificate');
    });

    test('unknown maps to UnknownAppError', () {
      final error = AppError.fromObject(
        DioException(
          requestOptions: requestOptions(),
          type: DioExceptionType.unknown,
          message: 'weird failure',
        ),
      );

      expect(error, isA<UnknownAppError>());
      expect(error.message, contains('weird failure'));
    });
  });

  group('convenience constructors', () {
    test('.network() creates NetworkAppError', () {
      final error = AppError.network('net down', code: 503);

      expect(error, isA<NetworkAppError>());
      expect(error.message, 'net down');
      expect(error.code, 503);
    });

    test('.server() creates ServerAppError', () {
      final error = AppError.server('oops', code: 500);

      expect(error, isA<ServerAppError>());
      expect(error.message, 'oops');
      expect(error.code, 500);
    });

    test('.auth() creates AuthAppError', () {
      final error = AppError.auth('nope', code: 401);

      expect(error, isA<AuthAppError>());
      expect(error.message, 'nope');
      expect(error.code, 401);
    });

    test('.data() creates DataAppError', () {
      final error = AppError.data('bad json', code: 422);

      expect(error, isA<DataAppError>());
      expect(error.message, 'bad json');
      expect(error.code, 422);
    });
  });

  group('message and code preservation', () {
    test('message is preserved through fromObject', () {
      final error = AppError.fromObject(
        const ServerException('exact message', code: 503),
      );

      expect(error.message, 'exact message');
    });

    test('code is preserved through fromObject', () {
      final error = AppError.fromObject(const AuthException('forbidden', code: 403));

      expect(error.code, 403);
    });

    test('null code is preserved', () {
      final error = AppError.fromObject(const NetworkException('no code'));

      expect(error.code, isNull);
    });

    test('cause is preserved through fromObject', () {
      final cause = Exception('root cause');
      final error = AppError.fromObject(NetworkException('wrapper', cause: cause));

      expect(error.cause, same(cause));
    });
  });
}
