import 'package:culcul/core/core.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';

mixin RequestExecutorBinding {
  RequestExecutor get requestExecutor;

  Future<Result<T, AppError>> requestResult<T>(Future<T> Function() apiCall) {
    return requestExecutor.run(apiCall);
  }

  Future<Result<T, AppError>> requestApiResult<T>(
    Future<ApiResponse<T>> Function() apiCall,
  ) async {
    return requestExecutor.runApi<T>(apiCall, transform: (data) => data as T);
  }

  Future<Result<void, AppError>> requestVoidResult(
    Future<ApiResponse<dynamic>> Function() apiCall,
  ) {
    return requestExecutor.runUnit(apiCall);
  }
}
