import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/response/api_response.dart';

class RequestExecutor {
  const RequestExecutor();

  Future<Result<T, AppError>> run<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<T, AppError>> runApi<T>(
    Future<ApiResponse<dynamic>> Function() action, {
    required T Function(dynamic data) transform,
  }) async {
    final result = await run(action);
    return result.when(
      success: (response) {
        if (!response.isSuccess) {
          return Failure(AppError.server(response.message, code: response.code));
        }
        final data = response.data;
        if (data == null) {
          return Failure(AppError.data('Response data is null', code: response.code));
        }
        try {
          return Success(transform(data));
        } catch (error) {
          return Failure(AppError.data('Failed to map response data', cause: error));
        }
      },
      failure: Failure.new,
    );
  }

  Future<T> runOrThrow<T>(Future<T> Function() action) async {
    final result = await run(action);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  Future<T> runApiOrThrow<T>(Future<ApiResponse<T>> Function() action) async {
    final result = await runApi<T>(action, transform: (data) => data as T);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  Future<Result<void, AppError>> runUnit(
    Future<ApiResponse<dynamic>> Function() action,
  ) async {
    final result = await run(action);
    return result.when(
      success: (response) {
        if (!response.isSuccess) {
          return Failure(AppError.server(response.message, code: response.code));
        }
        return const Success(null);
      },
      failure: Failure.new,
    );
  }

  Future<void> runUnitOrThrow(Future<ApiResponse<dynamic>> Function() action) async {
    final result = await runUnit(action);
    return result.when(
      success: (_) => null,
      failure: (error) => throw error.toException(),
    );
  }
}
