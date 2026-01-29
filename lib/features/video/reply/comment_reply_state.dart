import 'package:cilixili/data/models/video/comment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_reply_state.freezed.dart';

@freezed
abstract class CommentReplyState with _$CommentReplyState {
  const factory CommentReplyState({
    CommentItem? rootComment,
    @Default([]) List<CommentItem> replies,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoading,
    Object? error,
  }) = _CommentReplyState;
}
