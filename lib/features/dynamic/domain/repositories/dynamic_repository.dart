import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';

abstract class DynamicRepository {
  Future<Result<CommentResponse, AppError>> getComments(
    DynamicItem post, {
    CommentSort sort = CommentSort.hot,
    int page = 1,
  });

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

  Future<Result<CommentResponse, AppError>> getArticleCommentList({
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

  Future<Result<DynamicData, AppError>> getFeed({String? type, String? offset});

  Future<Result<DynamicData, AppError>> getSpaceDynamicFeed({
    required int hostMid,
    String? offset,
  });

  Future<Result<DynamicData, AppError>> getTopicFeed({
    required int topicId,
    String? offset,
  });

  Future<Result<DynamicItem, AppError>> getDetail(String id);

  Future<Result<ArticleDetailData, AppError>> getArticleDetail(String url);

  Future<Result<void, AppError>> likeDynamic(String id, bool like);

  Future<Result<DynamicUploadImageData, AppError>> uploadImage(File file);

  Future<Result<void, AppError>> publishDynamic({
    required String content,
    List<DynamicUploadImageData> images = const [],
  });
}
