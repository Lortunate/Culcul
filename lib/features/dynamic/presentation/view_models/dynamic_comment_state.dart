import 'package:culcul/shared/contracts/comment_contract.dart';
import 'package:culcul/shared/pagination/paged_list_state.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_comment_state.freezed.dart';

@freezed
sealed class DynamicCommentState with _$DynamicCommentState {
  const factory DynamicCommentState({
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
    @Default(CommentSort.hot) CommentSort sort,
  }) = _DynamicCommentState;
}
