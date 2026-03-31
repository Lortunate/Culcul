import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_comments_state.freezed.dart';

@freezed
sealed class VideoCommentsState with _$VideoCommentsState {
  const factory VideoCommentsState({
    @Default(PagedListState<CommentItem>()) PagedListState<CommentItem> paging,
    @Default(1) int sort,
  }) = _VideoCommentsState;
}
