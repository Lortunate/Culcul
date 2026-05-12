import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const executor = RequestExecutor();

  test('run returns Success for successful actions', () async {
    final result = await executor.run(() async => 42);

    expect(result, isA<Success<int, AppError>>());
    expect(result.dataOrNull, 42);
  });

  test('runApi returns ServerAppError when api response is unsuccessful', () async {
    final result = await executor.runApi<String, String>(
      () async => const ApiResponse<String>(code: -1, message: 'failed', data: 'ignored'),
      transform: (data) => data,
    );

    expect(result, isA<Failure<String, AppError>>());
    expect(result.errorOrNull, isA<ServerAppError>());
    expect(result.errorOrNull?.message, 'failed');
  });

  test('runApi returns DataAppError when transform throws', () async {
    final result = await executor.runApi<int, String>(
      () async => const ApiResponse<String>(code: 0, message: 'ok', data: 'bad'),
      transform: (data) => (data as List<Object?>).length,
    );

    expect(result, isA<Failure<int, AppError>>());
    expect(result.errorOrNull, isA<DataAppError>());
    expect(result.errorOrNull?.message, 'Failed to map response data');
  });
}
