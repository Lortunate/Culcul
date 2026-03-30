import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_comment_state.freezed.dart';

@freezed
sealed class DynamicCommentState with _$DynamicCommentState {
  const factory DynamicCommentState({
    @Default([]) List<CommentItem> comments,
    @Default(true) bool isLoading,
    @Default(false) bool hasMore,
    @Default(1) int page,
    @Default(1) int sort, // 0: time, 1: like (hot)
    AppError? error,
  }) = _DynamicCommentState;
}
