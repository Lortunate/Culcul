import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_comments_state.freezed.dart';

@freezed
sealed class VideoCommentsState with _$VideoCommentsState {
  const factory VideoCommentsState({
    @Default([]) List<CommentItem> comments,
    @Default(true) bool isInitialLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(1) int sort,
    @Default(1) int nextPage,
    Object? error,
  }) = _VideoCommentsState;
}
