import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/network/models/api_response.dart';

/// Base class for repositories that handle API calls with consistent error handling.
abstract class BaseRepository {
  BaseRepository({RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  final RequestExecutor _requestExecutor;

  Future<T> request<T>(Future<T> Function() apiCall) {
    return _requestExecutor.runOrThrow(apiCall);
  }

  Future<T> requestApi<T>(Future<ApiResponse<T>> Function() apiCall) {
    return _requestExecutor.runApiOrThrow(apiCall);
  }

  Future<void> requestVoid(Future<ApiResponse<dynamic>> Function() apiCall) {
    return _requestExecutor.runUnitOrThrow(apiCall);
  }

  Future<Result<T, AppError>> requestResult<T>(Future<T> Function() apiCall) {
    return _requestExecutor.run(apiCall);
  }

  Future<Result<T, AppError>> requestApiResult<T>(
    Future<ApiResponse<T>> Function() apiCall,
  ) async {
    return _requestExecutor.runApi<T>(apiCall, transform: (data) => data as T);
  }

  Future<Result<void, AppError>> requestVoidResult(
    Future<ApiResponse<dynamic>> Function() apiCall,
  ) {
    return _requestExecutor.runUnit(apiCall);
  }
}
