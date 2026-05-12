import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_list_state.freezed.dart';

@freezed
sealed class CommentListState with _$CommentListState {
  const factory CommentListState({
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
    @Default(CommentSort.hot) CommentSort sort,
  }) = _CommentListState;
}
