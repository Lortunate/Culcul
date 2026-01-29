import 'package:cilixili/features/video/reply/comment_reply_state.dart';
import 'package:cilixili/data/repositories/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_reply_controller.g.dart';

@riverpod
class CommentReplyController extends _$CommentReplyController {
  @override
  CommentReplyState build(int oid, int rootId) {
    Future.microtask(_init);
    return const CommentReplyState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = ref.read(videoRepositoryProvider);
      final response = await repo.fetchReply(oid: oid, root: rootId, pn: 1);

      state = state.copyWith(
        replies: response.replies,
        page: 2,
        hasMore: response.replies.isNotEmpty,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(videoRepositoryProvider);
      final response = await repo.fetchReply(
        oid: oid,
        root: rootId,
        pn: state.page,
      );

      state = state.copyWith(
        replies: [...state.replies, ...response.replies],
        page: state.page + 1,
        hasMore: response.replies.isNotEmpty,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}
