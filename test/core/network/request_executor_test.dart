import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/models/api_response.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepository extends BaseRepository {}

void main() {
  const executor = RequestExecutor();

  test('run maps AppException into AppError', () async {
    final result = await executor.run<void>(
      () async => throw const ServerException('boom', code: 500),
    );

    expect(result.errorOrNull, isA<ServerAppError>());
    expect(result.errorOrNull?.code, 500);
    expect(result.errorOrNull?.message, 'boom');
  });

  test('runApiOrThrow rethrows failed API responses as AppException', () async {
    await expectLater(
      executor.runApiOrThrow<String>(
        () async => const ApiResponse(code: 401, message: 'expired'),
      ),
      throwsA(
        isA<ServerException>()
            .having((error) => error.code, 'code', 401)
            .having((error) => error.message, 'message', 'expired'),
      ),
    );
  });

  test('base repository requestApiResult reuses unified executor path', () async {
    final repository = _FakeRepository();

    final result = await repository.requestApiResult<String>(
      () async => const ApiResponse(code: 0, message: 'ok', data: 'value'),
    );

    expect(result.dataOrNull, 'value');
    expect(result.errorOrNull, isNull);
  });

  test('base repository requestVoid keeps throw semantics', () async {
    final repository = _FakeRepository();

    await expectLater(
      repository.requestVoid(
        () async => const ApiResponse<void>(code: 2, message: 'failed'),
      ),
      throwsA(
        isA<ServerException>()
            .having((error) => error.code, 'code', 2)
            .having((error) => error.message, 'message', 'failed'),
      ),
    );
  });
}
