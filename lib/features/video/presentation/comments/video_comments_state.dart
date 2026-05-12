import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_comments_state.freezed.dart';

@freezed
sealed class VideoCommentsState with _$VideoCommentsState {
  const factory VideoCommentsState({
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
    @Default(CommentSort.hot) CommentSort sort,
  }) = _VideoCommentsState;
}
