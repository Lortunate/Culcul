import 'dart:io';

import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/models/dynamic_models.dart';

abstract class DynamicRepository {
  Future<CommentResponse> getComments(DynamicItem post, {int sort = 1, int page = 1});

  Future<CommentItem> addReply({
    required DynamicItem post,
    required String message,
    required int root,
    required int parent,
  });

  Future<void> likeComment({
    required DynamicItem post,
    required int rpid,
    required bool isLiked,
  });

  Future<CommentResponse> getArticleCommentList({
    required String oid,
    int mode = 3,
    int? next,
    String? referer,
  });

  Future<CommentItem> addCommentReply({
    required String oid,
    required int type,
    required int root,
    required int parent,
    required String message,
    String? referer,
  });

  Future<void> likeCommentByTarget({
    required String oid,
    required int type,
    required int rpid,
    required bool isLiked,
    String? referer,
  });

  Future<DynamicData> getFeed({String? type, String? offset});

  Future<DynamicData> getSpaceDynamicFeed({required int hostMid, String? offset});

  Future<DynamicData> getTopicFeed({required int topicId, String? offset});

  Future<DynamicItem> getDetail(String id);

  Future<ArticleDetailData> getArticleDetail(String url);

  Future<void> likeDynamic(String id, bool like);

  Future<DynamicUploadImageData> uploadImage(File file);

  Future<void> publishDynamic({
    required String content,
    List<DynamicUploadImageData> images = const [],
  });
}
