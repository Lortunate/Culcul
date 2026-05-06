import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';

typedef ToggleDynamicDetailLike = Future<String?> Function();
typedef AddDynamicDetailReply = Future<void> Function(int root, int parent, String text);
typedef LoadDynamicDetail = Future<void> Function();
typedef RefreshDynamicDetailComments = Future<void> Function();
typedef HasMoreDynamicDetailComments = bool Function();
typedef IsLoadingMoreDynamicDetailComments = bool Function();
typedef LoadMoreDynamicDetailComments = Future<void> Function();
typedef CurrentDynamicDetailCommentCount = int Function();

class DynamicDetailActions {
  DynamicDetailActions({
    required this.toggleLike,
    required this.addReply,
    required this.loadGate,
    required this.loadDetail,
    required this.refreshComments,
    required this.hasMoreComments,
    required this.isLoadingMoreComments,
    required this.loadMoreCommentsFromSource,
    required this.currentCommentCount,
    this.loadMoreSource = 'dynamic.dynamic_detail_comments',
  });

  final ToggleDynamicDetailLike toggleLike;
  final AddDynamicDetailReply addReply;
  final PaginationLoadGate loadGate;
  final LoadDynamicDetail loadDetail;
  final RefreshDynamicDetailComments refreshComments;
  final HasMoreDynamicDetailComments hasMoreComments;
  final IsLoadingMoreDynamicDetailComments isLoadingMoreComments;
  final LoadMoreDynamicDetailComments loadMoreCommentsFromSource;
  final CurrentDynamicDetailCommentCount currentCommentCount;
  final String loadMoreSource;

  Future<String?> handleLike() => toggleLike();

  Future<bool> submitComment(String rawText) async {
    final text = rawText.trim();
    if (text.isEmpty) {
      return false;
    }

    await addReply(0, 0, text);
    return true;
  }

  Future<void> refreshDetailAndComments() async {
    await loadDetail();
    await refreshComments();
  }

  Future<void> loadMoreComments() {
    return ScrollLoadTrigger.runWithNotifier(
      gate: loadGate,
      hasMore: hasMoreComments,
      isLoadingMore: isLoadingMoreComments,
      loadMore: loadMoreCommentsFromSource,
      itemCount: currentCommentCount,
      source: loadMoreSource,
    );
  }
}
