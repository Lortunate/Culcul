import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/api/dynamic_api.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/dynamic/dynamic_extension.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';

class DynamicRepository extends BaseRepository {
  final DynamicApi _api;
  final CookieJar _cookieJar;

  DynamicRepository(this._api, this._cookieJar);

  Future<String?> _getCsrfToken() async {
    final cookies = await _cookieJar.loadForRequest(Uri.parse('https://bilibili.com'));
    for (var cookie in cookies) {
      if (cookie.name == 'bili_jct') {
        return cookie.value;
      }
    }
    return null;
  }

  Future<Result<CommentResponse, AppException>> getComments(
    DynamicItem post, {
    int sort = 1,
    int page = 1,
  }) async {
    final params = _getCommentParams(post);
    if (params == null) {
      return const Failure(UnknownException('Unsupported dynamic type for comments'));
    }

    return safeApiCall(
      () => _api.getComments(
        oid: params['oid'] as int,
        type: params['type'] as int,
        sort: sort,
        pn: page,
        ps: 20,
      ),
    );
  }

  Future<Result<CommentItem, AppException>> addReply({
    required DynamicItem post,
    required String message,
    required int root,
    required int parent,
  }) async {
    final params = _getCommentParams(post);
    if (params == null) {
      return const Failure(UnknownException('Unsupported dynamic type for comments'));
    }

    return safeApiCall(
      () => _api.addReply(
        oid: params['oid'] as int,
        type: params['type'] as int,
        root: root,
        parent: parent,
        message: message,
      ),
    );
  }

  Future<Result<void, AppException>> likeComment({
    required DynamicItem post,
    required int rpid,
    required bool isLiked,
  }) async {
    final params = _getCommentParams(post);
    if (params == null) {
      return const Failure(UnknownException('Unsupported dynamic type for comments'));
    }

    return safeVoidApiCall(
      () => _api.actionComment(
        oid: params['oid'] as int,
        type: params['type'] as int,
        rpid: rpid,
        action: isLiked ? 1 : 0,
      ),
    );
  }

  Map<String, dynamic>? _getCommentParams(DynamicItem post) {
    if (post.commentId != null && post.commentType != null) {
      return {'oid': int.tryParse(post.commentId!) ?? 0, 'type': post.commentType!};
    }

    if (post.type == 'DYNAMIC_TYPE_AV') {
      if (post.videoContent != null) {
        // Use AID as oid, type 1
        return {'oid': int.tryParse(post.videoContent!.aid ?? '') ?? 0, 'type': 1};
      }
    } else if (post.type == 'DYNAMIC_TYPE_DRAW' ||
        post.type == 'DYNAMIC_TYPE_WORD' ||
        post.type == 'DYNAMIC_TYPE_FORWARD') {
      // Use dynamic ID (parsed) as oid, type 11 (draw) or 17 (word/forward)
      int type = 17;
      if (post.type == 'DYNAMIC_TYPE_DRAW') type = 11;
      return {'oid': int.tryParse(post.id) ?? 0, 'type': type};
    } else if (post.type == 'DYNAMIC_TYPE_ARTICLE') {
      // Article needs cvid (article ID).
    }

    // Fallback: try parsing ID and assume type 17 (most common for modern dynamics)
    return {'oid': int.tryParse(post.id) ?? 0, 'type': 17};
  }

  Future<Result<DynamicData, AppException>> getFeed({
    String? type,
    String? offset,
    int page = 1,
  }) {
    return safeApiCall(() => _api.getDynamicFeed(type: type, offset: offset, page: page));
  }

  Future<Result<DynamicData, AppException>> getSpaceDynamicFeed({
    required int hostMid,
    String? offset,
  }) {
    return safeApiCall(() => _api.getSpaceDynamicFeed(hostMid: hostMid, offset: offset));
  }

  Future<Result<DynamicData, AppException>> getTopicFeed({
    required int topicId,
    String? offset,
  }) {
    return safeApiCall(() => _api.getTopicFeed(topicId: topicId, offset: offset));
  }

  Future<Result<DynamicItem, AppException>> getDetail(String id) async {
    final result = await safeApiCall(() => _api.getDynamicDetail(id: id));
    return switch (result) {
      Success(value: final data) => Success(data.item),
      Failure(exception: final e) => Failure(e),
    };
  }

  Future<Result<void, AppException>> likeDynamic(String id, bool like) async {
    // We wrap the whole block in safeCall to catch any errors during token retrieval
    return safeCall(() async {
      final csrf = await _getCsrfToken();
      final response = await _api.likeDynamic(
        body: {'dyn_id_str': id, 'up': like ? 1 : 2},
        csrf: csrf ?? '',
      );
      if (!response.isSuccess) {
        throw ServerException(response.message, code: response.code);
      }
    });
  }

  Future<Result<DynamicUploadImageData, AppException>> uploadImage(File file) async {
    return safeApiCall(() async {
      final csrf = await _getCsrfToken();
      return _api.uploadImage(file: file, csrf: csrf ?? '');
    });
  }

  Future<Result<void, AppException>> publishDynamic({
    required String content,
    List<DynamicUploadImageData> images = const [],
  }) async {
    return safeCall(() async {
      final csrf = await _getCsrfToken();

      // Construct dyn_req
      final List<Map<String, dynamic>> contents = [];
      contents.add({'raw_text': content, 'type': 1, 'biz_id': ''});

      final List<Map<String, dynamic>> pics = [];
      for (var img in images) {
        pics.add({
          'img_src': img.imageUrl,
          'img_width': img.width,
          'img_height': img.height,
        });
      }

      final Map<String, dynamic> dynReq = {
        'content': {'contents': contents},
        'scene': images.isNotEmpty ? 2 : 1, // 1: text, 2: image
      };

      if (images.isNotEmpty) {
        dynReq['pics'] = pics;
      }

      final response = await _api.createDynamic(
        csrf: csrf ?? '',
        body: {'dyn_req': dynReq},
      );

      if (!response.isSuccess) {
        throw ServerException(response.message, code: response.code);
      }
    });
  }
}
