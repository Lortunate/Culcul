import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_comment_state.freezed.dart';

@freezed
sealed class DynamicCommentState with _$DynamicCommentState {
  const factory DynamicCommentState({
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
    @Default(CommentSort.hot) CommentSort sort,
    AppError? error, // kept for backward compatibility while migrating call sites
  }) = _DynamicCommentState;
}
