import 'package:culcul/features/video/models/video_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_reply_state.freezed.dart';

@freezed
sealed class CommentReplyState with _$CommentReplyState {
  const factory CommentReplyState({
    CommentItem? rootComment,
    @Default([]) List<CommentItem> replies,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoading,
    Object? error,
  }) = _CommentReplyState;
}
