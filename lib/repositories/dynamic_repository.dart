import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/data/api/dynamic_api.dart';
import 'package:culcul/data/mappers/dynamic_mapper.dart';
import 'package:culcul/data/models/comment_model.dart';
import 'package:culcul/data/models/dynamic/dynamic_response.dart';
import 'package:culcul/domain/entities/dynamic_post.dart';

class DynamicRepository {
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
    DynamicPost post, {
    int sort = 1,
    int page = 1,
  }) async {
    try {
      final params = _getCommentParams(post);
      if (params == null) {
        return Failure(UnknownException('Unsupported dynamic type for comments'));
      }

      final query = {
        'oid': params['oid'],
        'type': params['type'],
        'sort': sort,
        'pn': page,
        'ps': 20,
      };

      final response = await _api.getComments(query);
      if (response.isSuccess && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<CommentItem, AppException>> addReply({
    required DynamicPost post,
    required String message,
    required int root,
    required int parent,
  }) async {
    try {
      final params = _getCommentParams(post);
      if (params == null) {
        return Failure(UnknownException('Unsupported dynamic type for comments'));
      }

      final response = await _api.addReply(
        oid: params['oid'] as int,
        type: params['type'] as int,
        root: root,
        parent: parent,
        message: message,
      );

      if (response.isSuccess && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<void, AppException>> likeComment({
    required DynamicPost post,
    required int rpid,
    required bool isLiked,
  }) async {
    try {
      final params = _getCommentParams(post);
      if (params == null) {
        return Failure(UnknownException('Unsupported dynamic type for comments'));
      }

      final response = await _api.actionComment(
        oid: params['oid'] as int,
        type: params['type'] as int,
        rpid: rpid,
        action: isLiked ? 1 : 0,
      );

      if (response.isSuccess) {
        return const Success(null);
      } else {
        return Failure(ServerException(response.message, code: response.code));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Map<String, dynamic>? _getCommentParams(DynamicPost post) {
    if (post.commentId != null && post.commentType != null) {
      return {
        'oid': int.tryParse(post.commentId!) ?? 0,
        'type': post.commentType!
      };
    }
    
    if (post.type == 'DYNAMIC_TYPE_AV') {
      if (post.video != null) {
        // Use AID as oid, type 1
        return {'oid': int.tryParse(post.video!.aid ?? '') ?? 0, 'type': 1};
      }
    } else if (post.type == 'DYNAMIC_TYPE_DRAW' ||
        post.type == 'DYNAMIC_TYPE_WORD' ||
        post.type == 'DYNAMIC_TYPE_FORWARD') {
      // Use dynamic ID (parsed) as oid, type 11 (draw) or 17 (word/forward)
      // Usually draw is 11, word/forward is 17.
      // But let's check exact mapping.
      int type = 17;
      if (post.type == 'DYNAMIC_TYPE_DRAW') type = 11;
      // forward is 17? Yes, usually.
      return {'oid': int.tryParse(post.id) ?? 0, 'type': type};
    } else if (post.type == 'DYNAMIC_TYPE_ARTICLE') {
       // Article needs cvid (article ID).
       // We might not have it easily in DynamicPost unless mapped.
       // For now, return null or try to find it.
       // Assuming we don't support article comments yet or need to parse ID.
    }
    
    // Fallback: try parsing ID and assume type 17 (most common for modern dynamics)
    return {'oid': int.tryParse(post.id) ?? 0, 'type': 17};
  }

  // Replaced by getFeed using DynamicMapper

  Future<Result<DynamicFeed, AppException>> getFeed({
    String type = 'all',
    String? offset,
    int page = 1,
  }) async {
    try {
      final response = await _api.getDynamicFeed(
        type: type,
        offset: offset,
        page: page,
      );

      if (response.data == null) {
        return Failure(ServerException('No data', code: response.code));
      }

      final data = response.data!;

      return Success(DynamicFeed(
        hasMore: data.hasMore,
        offset: data.offset,
        items: data.items.map((item) => DynamicMapper.mapToEntity(item)).toList(),
      ));
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<DynamicFeed, AppException>> getUserFeed({
    required int hostMid,
    String? offset,
  }) async {
    try {
      final response = await _api.getSpaceDynamicFeed(
        hostMid: hostMid,
        offset: offset,
      );

      if (response.data == null) {
        return Failure(ServerException('No data', code: response.code));
      }

      final data = response.data!;

      return Success(DynamicFeed(
        hasMore: data.hasMore,
        offset: data.offset,
        items: data.items.map((item) => DynamicMapper.mapToEntity(item)).toList(),
      ));
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<DynamicFeed, AppException>> getTopicFeed({
    required int topicId,
    String? offset,
    int sortBy = 0,
  }) async {
    try {
      final response = await _api.getTopicFeed(
        topicId: topicId,
        offset: offset,
        sortBy: sortBy,
      );

      if (response.data == null) {
        return Failure(ServerException('No data', code: response.code));
      }

      final data = response.data!;

      return Success(DynamicFeed(
        hasMore: data.hasMore,
        offset: data.offset,
        items: data.items.map((item) => DynamicMapper.mapToEntity(item)).toList(),
      ));
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<DynamicPost, AppException>> getDetail(String id) async {
    try {
      final response = await _api.getDynamicDetail(id: id);
      if (response.data == null) {
        return Failure(ServerException('Dynamic not found', code: response.code));
      }
      return Success(DynamicMapper.mapToEntity(response.data!.item));
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<void, AppException>> likeDynamic(String id, bool like) async {
    try {
      final csrf = await _getCsrfToken();
      await _api.likeDynamic(
        body: {
          'dyn_id_str': id,
          'up': like ? 1 : 2,
        },
        csrf: csrf ?? '',
      );
      return const Success(null);
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<DynamicUploadImageData, AppException>> uploadImage(File file) async {
    try {
      final csrf = await _getCsrfToken();
      final response = await _api.uploadImage(file: file, csrf: csrf ?? '');
      if (response.data == null) {
        return Failure(ServerException('Upload failed', code: response.code));
      }
      return Success(response.data!);
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  Future<Result<void, AppException>> publishDynamic({
    required String content,
    List<DynamicUploadImageData> images = const [],
  }) async {
    try {
      final csrf = await _getCsrfToken();

      // Construct dyn_req
      final List<Map<String, dynamic>> contents = [];
      contents.add({
        'raw_text': content,
        'type': 1,
        'biz_id': '',
      });

      final List<Map<String, dynamic>> pics = [];
      for (var img in images) {
        pics.add({
          'img_src': img.imageUrl,
          'img_width': img.width,
          'img_height': img.height,
        });
      }

      final Map<String, dynamic> dynReq = {
        'content': {
          'contents': contents,
        },
        'scene': images.isNotEmpty ? 2 : 1, // 1: text, 2: image
      };

      if (images.isNotEmpty) {
        dynReq['pics'] = pics;
      }

      await _api.createDynamic(
        csrf: csrf ?? '',
        body: {'dyn_req': dynReq},
      );
      return const Success(null);
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString(), cause: e));
    }
  }

  // Methods moved to DynamicMapper
}
