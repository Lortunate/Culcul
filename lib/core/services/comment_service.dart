import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_service.g.dart';

@Riverpod(keepAlive: true)
CommentService commentService(Ref ref) {
  return CommentService(ref.watch(dioClientProvider));
}

class CommentService {
  final Dio _dio;

  CommentService(this._dio);

  Future<ApiResponse<CommentResponse>> fetchComments({
    required String oid,
    required int type,
    CommentSort sort = CommentSort.hot,
    int page = 1,
    int pageSize = 20,
    String? referer,
    String? origin,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.reply,
      queryParameters: {
        'oid': oid,
        'type': type,
        'sort': sort.apiValue,
        'pn': page,
        'ps': pageSize,
      },
      options: _options(wbi: true, referer: referer, origin: origin),
      cancelToken: cancelToken,
    );
    return _decodeResponse(response, CommentResponse.fromJson);
  }

  Future<ApiResponse<CommentResponse>> fetchReply({
    required String oid,
    required int root,
    required int type,
    int page = 1,
    int pageSize = 20,
    String? referer,
    String? origin,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.replyReply,
      queryParameters: {
        'oid': oid,
        'root': root,
        'type': type,
        'pn': page,
        'ps': pageSize,
      },
      options: _options(wbi: true, referer: referer, origin: origin),
      cancelToken: cancelToken,
    );
    return _decodeResponse(response, CommentResponse.fromJson);
  }

  Future<ApiResponse<void>> actionComment({
    required String oid,
    required int rpid,
    required int action,
    required int type,
    String? referer,
    String? origin,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.replyAction,
      data: {'oid': oid, 'rpid': rpid, 'action': action, 'type': type},
      options: _options(
        csrf: true,
        referer: referer,
        origin: origin,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return _decodeVoidResponse(response);
  }

  Future<ApiResponse<void>> hateComment({
    required String oid,
    required int rpid,
    required int action,
    required int type,
    String? referer,
    String? origin,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.replyHate,
      data: {'oid': oid, 'rpid': rpid, 'action': action, 'type': type},
      options: _options(
        csrf: true,
        referer: referer,
        origin: origin,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return _decodeVoidResponse(response);
  }

  Future<ApiResponse<CommentItem>> addReply({
    required String oid,
    required int root,
    required int parent,
    required String message,
    required int type,
    String? referer,
    String? origin,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.replyAdd,
      data: {
        'oid': oid,
        'root': root,
        'parent': parent,
        'message': message,
        'type': type,
      },
      options: _options(
        csrf: true,
        referer: referer,
        origin: origin,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return _decodeResponse(response, CommentItem.fromJson);
  }

  Options _options({
    bool wbi = false,
    bool csrf = false,
    String? referer,
    String? origin,
    String? contentType,
  }) {
    final headers = <String, Object?>{
      if (wbi) 'x-bili-wbi': 'true',
      if (csrf) 'x-bili-csrf': 'true',
    };
    if (referer != null) {
      headers['Referer'] = referer;
    }
    if (origin != null) {
      headers['Origin'] = origin;
    }
    return Options(headers: headers, contentType: contentType);
  }

  ApiResponse<T> _decodeResponse<T>(
    Response<Map<String, dynamic>> response,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    final body = response.data;
    if (body == null) {
      throw StateError('Response data is null');
    }
    return ApiResponse<T>.fromJson(
      body,
      (json) => fromJson(Map<String, dynamic>.from(json as Map)),
    );
  }

  ApiResponse<void> _decodeVoidResponse(Response<Map<String, dynamic>> response) {
    final body = response.data;
    if (body == null) {
      throw StateError('Response data is null');
    }
    return ApiResponse<void>.fromJson(body, (_) {});
  }
}
