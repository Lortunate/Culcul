import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';

abstract class DynamicRepository {
  Future<CommentResponse> getComments(DynamicItem post, {int sort = 1, int page = 1});

  Future<Result<CommentItem, AppError>> addReply({
    required DynamicItem post,
    required String message,
    required int root,
    required int parent,
  });

  Future<Result<void, AppError>> likeComment({
    required DynamicItem post,
    required int rpid,
    required bool isLiked,
  });

  Future<CommentResponse> getArticleCommentList({
    required ArticleDetailData article,
    int? next,
  });

  Future<Result<CommentItem, AppError>> addArticleCommentReply({
    required ArticleDetailData article,
    required int root,
    required int parent,
    required String message,
  });

  Future<Result<void, AppError>> likeArticleComment({
    required ArticleDetailData article,
    required int rpid,
    required bool isLiked,
  });

  Future<DynamicData> getFeed({String? type, String? offset});

  Future<DynamicData> getSpaceDynamicFeed({required int hostMid, String? offset});

  Future<DynamicData> getTopicFeed({required int topicId, String? offset});

  Future<DynamicItem> getDetail(String id);

  Future<ArticleDetailData> getArticleDetail(String url);

  Future<Result<void, AppError>> likeDynamic(String id, bool like);

  Future<Result<DynamicUploadImageData, AppError>> uploadImage(File file);

  Future<Result<void, AppError>> publishDynamic({
    required String content,
    List<DynamicUploadImageData> images = const [],
  });
}
