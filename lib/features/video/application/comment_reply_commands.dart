import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:culcul/shared/pagination/scroll_load_trigger.dart';

class CommentReplyCommands {
  CommentReplyCommands({
    required this.loadGate,
    required this.addReply,
    required this.hasMoreReplies,
    required this.isLoadingMoreReplies,
    required this.loadMoreRepliesFromController,
    required this.currentReplyCount,
    this.loadMoreSource = 'video.comment_reply',
  });

  final PaginationLoadGate loadGate;
  final Future<void> Function(int oid, int root, int parent, String text) addReply;
  final bool Function() hasMoreReplies;
  final bool Function() isLoadingMoreReplies;
  final Future<void> Function() loadMoreRepliesFromController;
  final int Function() currentReplyCount;
  final String loadMoreSource;

  Future<void> submitReply(CommentItem item, String text) {
    final root = item.root == 0 ? item.rpid : item.root;
    return addReply(item.oid, root, item.rpid, text);
  }

  Future<void> loadMoreReplies() {
    return ScrollLoadTrigger.runWithNotifier(
      gate: loadGate,
      hasMore: hasMoreReplies,
      isLoadingMore: isLoadingMoreReplies,
      loadMore: loadMoreRepliesFromController,
      itemCount: currentReplyCount,
      source: loadMoreSource,
    );
  }
}
