import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';

abstract interface class ArticleDetailPort {
  Future<Result<ArticleDetailData, AppError>> getArticleDetail(String url);

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
}
