import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/data/models/response/api_response.dart';
import 'package:dio/dio.dart';

/// Base class for repositories that handle API calls with consistent error handling.
abstract class BaseRepository {
  Future<T> request<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (error, stackTrace) {
      throw _toAppException(error, stackTrace);
    }
  }

  Future<T> requestApi<T>(Future<ApiResponse<T>> Function() apiCall) async {
    final response = await request(apiCall);
    if (!response.isSuccess) {
      throw ServerException(response.message, code: response.code);
    }

    final data = response.data;
    if (data == null) {
      throw ServerException('Response data is null', code: response.code);
    }
    return data;
  }

  Future<void> requestVoid(Future<ApiResponse<dynamic>> Function() apiCall) async {
    final response = await request(apiCall);
    if (!response.isSuccess) {
      throw ServerException(response.message, code: response.code);
    }
  }

  AppException _toAppException(Object error, StackTrace stackTrace) {
    if (error is AppException) return error;
    if (error is DioException) return dioExceptionToAppException(error);
    return UnknownException('Unexpected error occurred: $error', cause: error);
  }
}