import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:dio/dio.dart';

ApiResponse<T> decodeApiResponse<T>(
  Response<Map<String, dynamic>> response,
  T Function(Object? json) fromJsonT, {
  Map<String, dynamic>? nullBody,
}) {
  final body = response.data ?? nullBody;
  if (body == null) {
    throw StateError('Response data is null');
  }
  return ApiResponse<T>.fromJson(body, fromJsonT);
}

ApiResponse<T> decodeObjectApiResponse<T>(
  Response<Map<String, dynamic>> response,
  T Function(Map<String, dynamic> json) fromJson, {
  Map<String, dynamic>? nullBody,
}) {
  return decodeApiResponse<T>(response, (json) {
    if (json is Map<String, dynamic>) {
      return fromJson(json);
    }
    if (json is Map) {
      return fromJson(Map<String, dynamic>.from(json));
    }
    throw StateError('ApiResponse data is not a JSON object');
  }, nullBody: nullBody);
}
