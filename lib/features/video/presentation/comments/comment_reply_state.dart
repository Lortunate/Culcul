import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_reply_state.freezed.dart';

@freezed
sealed class CommentReplyState with _$CommentReplyState {
  const factory CommentReplyState({
    CommentItem? rootComment,
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
  }) = _CommentReplyState;
}
