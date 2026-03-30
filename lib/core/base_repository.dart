import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:dio/dio.dart';

/// Base class for repositories that handle API calls with consistent error handling.
abstract class BaseRepository {
  Future<T> request<T>(Future<T> Function() apiCall) async {
    final result = await requestResult(apiCall);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  Future<T> requestApi<T>(Future<ApiResponse<T>> Function() apiCall) async {
    final result = await requestApiResult(apiCall);
    return result.when(
      success: (value) => value,
      failure: (error) => throw error.toException(),
    );
  }

  Future<void> requestVoid(Future<ApiResponse<dynamic>> Function() apiCall) async {
    final result = await requestVoidResult(apiCall);
    return result.when(
      success: (_) => null,
      failure: (error) => throw error.toException(),
    );
  }

  Future<Result<T, AppError>> requestResult<T>(Future<T> Function() apiCall) async {
    try {
      return Success(await apiCall());
    } catch (error, stackTrace) {
      return Failure(_toAppError(error, stackTrace));
    }
  }

  Future<Result<T, AppError>> requestApiResult<T>(
    Future<ApiResponse<T>> Function() apiCall,
  ) async {
    final result = await requestResult(apiCall);
    return result.when(
      success: (response) {
        if (!response.isSuccess) {
          return Failure(
            AppError.fromException(
              ServerException(response.message, code: response.code),
            ),
          );
        }

        final data = response.data;
        if (data == null) {
          return Failure(
            AppError.fromException(
              ServerException('Response data is null', code: response.code),
            ),
          );
        }
        return Success(data);
      },
      failure: (error) => Failure(error),
    );
  }

  Future<Result<void, AppError>> requestVoidResult(
    Future<ApiResponse<dynamic>> Function() apiCall,
  ) async {
    final result = await requestResult(apiCall);
    return result.when(
      success: (response) {
        if (!response.isSuccess) {
          return Failure(
            AppError.fromException(
              ServerException(response.message, code: response.code),
            ),
          );
        }
        return const Success(null);
      },
      failure: (error) => Failure(error),
    );
  }

  AppError _toAppError(Object error, StackTrace _) {
    if (error is AppException) {
      return AppError.fromException(error);
    }
    if (error is DioException) {
      return AppError.fromException(dioExceptionToAppException(error));
    }
    return UnknownAppError('Unexpected error occurred: $error', cause: error);
  }
}
