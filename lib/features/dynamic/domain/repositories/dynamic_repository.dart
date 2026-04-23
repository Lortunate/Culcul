import 'dart:io';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/shared/network/request_cancel_token.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';

class DynamicFeedQuery {
  final String? type;
  final String? offset;

  const DynamicFeedQuery({this.type, this.offset});
}

class SpaceDynamicFeedQuery {
  final int hostMid;
  final String? offset;
  final bool forceRefresh;
  final RequestCancelToken? cancelToken;

  const SpaceDynamicFeedQuery({
    required this.hostMid,
    this.offset,
    this.forceRefresh = false,
    this.cancelToken,
  });
}

class TopicDynamicFeedQuery {
  final int topicId;
  final String? offset;

  const TopicDynamicFeedQuery({required this.topicId, this.offset});
}

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

  Future<Result<DynamicData, AppError>> getFeed(DynamicFeedQuery query);

  Future<Result<DynamicData, AppError>> getSpaceDynamicFeed(SpaceDynamicFeedQuery query);

  Future<Result<DynamicData, AppError>> getTopicFeed(TopicDynamicFeedQuery query);

  Future<Result<DynamicItem, AppError>> getDetail(String id);

  Future<Result<ArticleDetailData, AppError>> getArticleDetail(String url);

  Future<Result<void, AppError>> likeDynamic(String id, bool like);

  Future<Result<String, AppError>> getPublishCsrf();

  Future<Result<List<DynamicUploadImageData>, AppError>> uploadImagesWithCsrf({
    required List<File> files,
    required String csrf,
  });

  Future<Result<void, AppError>> publishDynamic({
    required String content,
    required String csrf,
    List<DynamicUploadImageData> images = const [],
  });
}
