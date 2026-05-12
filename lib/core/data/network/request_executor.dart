import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/data/network/models/api_response.dart';

class RequestExecutor {
  const RequestExecutor();

  Future<Result<T, AppError>> run<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<T, AppError>> runApi<T, D>(
    Future<ApiResponse<D>> Function() action, {
    required T Function(D data) transform,
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

  Future<Result<void, AppError>> runUnit<D>(
    Future<ApiResponse<D>> Function() action,
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

  Future<Result<void, AppError>> runVoid(Future<void> Function() action) async {
    final result = await run(action);
    return result.when(success: (_) => const Success(null), failure: Failure.new);
  }
}
