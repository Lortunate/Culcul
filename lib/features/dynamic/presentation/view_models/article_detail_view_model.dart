import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/dynamic/application/dynamic_workflows.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:culcul/features/dynamic/data/dynamic_repository_impl.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_detail_view_model.freezed.dart';
part 'article_detail_view_model.g.dart';
part 'article_detail_view_model.actions.dart';

@freezed
sealed class ArticleDetailUiState with _$ArticleDetailUiState {
  const factory ArticleDetailUiState({
    ArticleDetailData? detail,
    @Default(true) bool isLoading,
    AppError? error,
    @Default([]) List<CommentItem> comments,
    @Default(false) bool commentsLoading,
    String? commentsError,
    int? commentsNext,
    @Default(true) bool commentsHasMore,
    @Default(false) bool isSendingComment,
  }) = _ArticleDetailUiState;

  const ArticleDetailUiState._();

  bool get commentsEnabled => (detail?.commentOid ?? '').isNotEmpty;
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
