import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';

final class CommentListState {
  const CommentListState({
    this.paging = const PagedListState<CommentItem>(),
    this.sort = CommentSort.hot,
  });

  final PagedListState<CommentItem> paging;
  final CommentSort sort;

  CommentListState copyWith({PagedListState<CommentItem>? paging, CommentSort? sort}) {
    return CommentListState(paging: paging ?? this.paging, sort: sort ?? this.sort);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CommentListState && other.paging == paging && other.sort == sort;
  }

  @override
  int get hashCode => Object.hash(paging, sort);

  @override
  String toString() {
    return 'CommentListState(paging: $paging, sort: $sort)';
  }
}
