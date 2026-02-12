import 'package:culcul/core/types/result.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:dio/dio.dart';

/// Base class for repositories that handle API calls with consistent error handling
abstract class BaseRepository {
  /// Wraps an API call in a Result type with consistent error handling
  Future<Result<T, AppException>> safeCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return Success(result);
    } on AppException catch (e) {
      return Failure(e);
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException('Unexpected error occurred: $e', cause: e));
    }
  }

  /// Wraps an API call that returns an ApiResponse and extracts the data
  Future<Result<T, AppException>> safeApiCall<T>(
    Future<ApiResponse<T>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      if (response.isSuccess) {
        if (response.data != null) {
          return Success(response.data as T);
        }
        return Failure(ServerException('Response data is null', code: response.code));
      }
      return Failure(ServerException(response.message, code: response.code));
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException('Unexpected error occurred: $e', cause: e));
    }
  }

  /// Wraps an API call where we don't care about the return data (just success/fail)
  Future<Result<void, AppException>> safeVoidApiCall(
    Future<ApiResponse<dynamic>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      if (response.isSuccess) {
        return const Success(null);
      }
      return Failure(ServerException(response.message, code: response.code));
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException('Unexpected error occurred: $e', cause: e));
    }
  }


  /// Wraps an API call that returns a nullable value
  Future<Result<T?, AppException>> safeCallNullable<T>(
    Future<T?> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return Success(result);
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(UnknownException('Unexpected error occurred: $e'));
    }
  }

  /// Maps a list of items using a mapper function, handling potential errors
  List<R> safeMapList<T, R>(List<T> items, R Function(T item) mapper) {
    try {
      return items.map(mapper).toList();
    } catch (e) {
      // Log error or handle as needed
      return [];
    }
  }

  /// Safely extracts a value from a map with a default fallback
  T safeGetFromMap<T>(Map<String, dynamic> map, String key, T defaultValue) {
    try {
      final value = map[key];
      return value is T ? value : defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Performs a conditional API call based on a predicate
  Future<Result<T, AppException>> conditionalCall<T>(
    bool condition,
    Future<T> Function() apiCall,
    T defaultValue,
  ) async {
    if (condition) {
      return safeCall(apiCall);
    } else {
      return Success(defaultValue);
    }
  }

  /// Combines multiple API calls and returns all results or the first error
  Future<Result<List<T>, AppException>> combineCalls<T>(
    List<Future<T> Function()> apiCalls,
  ) async {
    final results = <T>[];

    for (final call in apiCalls) {
      final result = await safeCall(call);
      if (result case Failure(exception: final e)) {
        return Failure(e);
      }

      if (result case Success(value: final value)) {
        results.add(value);
      }
    }

    return Success(results);
  }

  /// Handles paginated API calls with consistent error handling
  Future<Result<List<T>, AppException>> paginatedCall<T>(
    Future<List<T>> Function(int page, int pageSize) apiCall,
    int startPage,
    int pageSize,
    int totalPages,
  ) async {
    final allResults = <T>[];

    for (int page = startPage; page < totalPages; page++) {
      final result = await safeCall(() => apiCall(page, pageSize));

      if (result case Failure(exception: final e)) {
        return Failure(e);
      }

      if (result case Success(value: final pageResults)) {
        allResults.addAll(pageResults);

        // If we got fewer results than expected, we might have reached the end
        if (pageResults.length < pageSize) {
          break;
        }
      }
    }

    return Success(allResults);
  }
}
