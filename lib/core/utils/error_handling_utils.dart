import 'dart:math' as math;
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/result.dart';
import 'package:dio/dio.dart';

/// Utility class for standardized error handling across the application
class ErrorHandlingUtils {
  /// Converts various error types to AppException
  static AppException toAppException(dynamic error) {
    if (error is AppException) {
      return error;
    } else if (error is DioException) {
      return dioExceptionToAppException(error);
    } else {
      return UnknownException(error.toString(), cause: error);
    }
  }

  /// Creates a Result from an async operation with standardized error handling
  static Future<Result<T, AppException>> wrapAsyncOperation<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final result = await operation();
      return Success(result);
    } on AppException catch (e) {
      return Failure(e);
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  /// Creates a Result from a synchronous operation with standardized error handling
  static Result<T, AppException> wrapSyncOperation<T>(T Function() operation) {
    try {
      final result = operation();
      return Success(result);
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  /// Checks if an error represents a network issue
  static bool isNetworkError(AppException exception) {
    return exception is NetworkException;
  }

  /// Checks if an error represents an authentication issue
  static bool isAuthError(AppException exception) {
    return exception is AuthException;
  }

  /// Checks if an error represents a server-side issue
  static bool isServerError(AppException exception) {
    return exception is ServerException;
  }

  /// Checks if an error represents a client-side data issue
  static bool isDataError(AppException exception) {
    return exception is DataException;
  }

  /// Retries an operation with exponential backoff for transient errors
  static Future<Result<T, AppException>> retryOperation<T>({
    required Future<Result<T, AppException>> Function() operation,
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
  }) async {
    Result<T, AppException> lastResult = const Failure(
      UnknownException('No attempts made'),
    );

    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      lastResult = await operation();

      // If successful, return the result
      if (lastResult.isSuccess) {
        return lastResult;
      }

      // If it's a failure, check if it should be retried
      if (lastResult is Failure<dynamic, AppException>) {
        final ex = (lastResult as Failure<dynamic, AppException>).exception;
        if (!shouldRetry(ex)) {
          return lastResult;
        }
      }

      // Wait before retrying (exponential backoff)
      if (attempt < maxAttempts) {
        final delay = initialDelay * math.pow(2, attempt - 1).toInt();
        await Future.delayed(delay);
      }
    }

    return lastResult;
  }

  /// Determines if an error should be retried
  static bool shouldRetry(AppException exception) {
    // Retry on network errors, timeouts, and server errors
    return exception is NetworkException ||
        exception is ServerException ||
        (exception is UnknownException &&
            exception.message.toLowerCase().contains('timeout'));
  }
}

