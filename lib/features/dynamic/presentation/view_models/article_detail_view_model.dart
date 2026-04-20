import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:culcul/features/dynamic/feature_scope.dart';
import 'package:culcul/shared/errors/app_error.dart';
import 'package:culcul/shared/perf/feature_flow_perf_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_detail_view_model.g.dart';
part 'article_detail_view_model.actions.dart';

class ArticleDetailUiState {
  final ArticleDetailData? detail;
  final bool isLoading;
  final AppError? error;
  final List<CommentItem> comments;
  final bool commentsLoading;
  final String? commentsError;
  final int? commentsNext;
  final bool commentsHasMore;
  final bool isSendingComment;

  const ArticleDetailUiState({
    this.detail,
    this.isLoading = true,
    this.error,
    this.comments = const [],
    this.commentsLoading = false,
    this.commentsError,
    this.commentsNext,
    this.commentsHasMore = true,
    this.isSendingComment = false,
  });

  bool get commentsEnabled => (detail?.commentOid ?? '').isNotEmpty;

  ArticleDetailUiState copyWith({
    ArticleDetailData? detail,
    bool setDetail = false,
    bool? isLoading,
    AppError? error,
    bool clearError = false,
    List<CommentItem>? comments,
    bool? commentsLoading,
    String? commentsError,
    bool clearCommentsError = false,
    int? commentsNext,
    bool clearCommentsNext = false,
    bool? commentsHasMore,
    bool? isSendingComment,
  }) {
    return ArticleDetailUiState(
      detail: setDetail ? detail : this.detail,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      comments: comments ?? this.comments,
      commentsLoading: commentsLoading ?? this.commentsLoading,
      commentsError: clearCommentsError ? null : (commentsError ?? this.commentsError),
      commentsNext: clearCommentsNext ? null : (commentsNext ?? this.commentsNext),
      commentsHasMore: commentsHasMore ?? this.commentsHasMore,
      isSendingComment: isSendingComment ?? this.isSendingComment,
    );
  }
}

@riverpod
class ArticleDetailViewModel extends _$ArticleDetailViewModel
    with _ArticleDetailViewModelActions {
  @override
  late final String _url;

  @override
  ArticleDetailUiState build(String url) {
    _url = url;
    unawaited(Future<void>.microtask(refreshAll));
    return const ArticleDetailUiState();
  }
}
