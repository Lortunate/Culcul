import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/network/models/api_response.dart';
import 'package:culcul/shared/network/request_executor.dart';
import 'package:culcul/shared/result/result.dart';

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
