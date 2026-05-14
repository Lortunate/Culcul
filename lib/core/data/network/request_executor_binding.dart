import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/data/network/models/api_response.dart';

mixin RequestExecutorBinding {
  RequestExecutor get requestExecutor;

  Future<Result<T, AppError>> requestResult<T>(
    Future<T> Function() apiCall, {
    RequestExecutionOptions? options,
  }) {
    return requestExecutor.run(apiCall, options: options);
  }

  Future<Result<T, AppError>> requestApiResult<T>(
    Future<ApiResponse<T>> Function() apiCall, {
    RequestExecutionOptions? options,
  }) async {
    return requestExecutor.runApi<T, T>(
      apiCall,
      transform: (data) => data,
      options: options,
    );
  }

  Future<Result<void, AppError>> requestVoidResult(
    Future<ApiResponse<dynamic>> Function() apiCall, {
    RequestExecutionOptions? options,
  }) {
    return requestExecutor.runUnit(apiCall, options: options);
  }
}
