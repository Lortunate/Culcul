import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/video_comment_application_providers.dart';
import 'package:culcul/features/video/application/video_comment_port.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_view_model.dart';
import 'package:culcul/features/video/presentation/comments/video_comments_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_state.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test(
    'reply thread controller reads and mutates through the application port',
    () async {
      const oid = 100;
      const root = 10;
      final firstReply = _comment(rpid: 11, root: root, like: 2);
      final nextReply = _comment(rpid: 12, root: root);
      final port = _FakeVideoCommentPort(
        replyResponses: [
          CommentResponse(replies: [firstReply]),
          CommentResponse(replies: [nextReply]),
          CommentResponse(replies: [firstReply]),
        ],
      );
      final provider = commentReplyControllerProvider(oid, root);
      final container = ProviderContainer(
        overrides: [
          videoCommentPortProvider.overrideWithValue(port),
          videoRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'videoRepositoryProvider should not be read by comments UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(provider, (_, _) {});
      addTearDown(subscription.close);

      final notifier = container.read(provider.notifier);
      await _waitForCommentReplyItems(container, provider);

      expect(port.fetchReplyCalls.single, (oid: oid, root: root, page: 1));
      expect(container.read(provider).paging.items, [firstReply]);

      await notifier.loadMore();

      expect(port.fetchReplyCalls.last, (oid: oid, root: root, page: 2));
      expect(container.read(provider).paging.items, [firstReply, nextReply]);

      await notifier.toggleCommentLike(oid, firstReply.rpid, false);

      expect(port.likeCalls.single, (oid: oid, rpid: firstReply.rpid, isLiked: true));
      expect(container.read(provider).paging.items.first.like, 3);

      await notifier.toggleCommentDislike(oid, firstReply.rpid);

      expect(port.dislikeCalls.single, (
        oid: oid,
        rpid: firstReply.rpid,
        isDisliked: true,
      ));

      await notifier.addReply(oid, root, firstReply.rpid, 'hello');

      expect(port.replyCalls.single, (
        oid: oid,
        root: root,
        parent: firstReply.rpid,
        message: 'hello',
      ));
      expect(port.fetchReplyCalls.last, (oid: oid, root: root, page: 1));
    },
  );

  test(
    'video comments controller reads and mutates through the application port',
    () async {
      const bvid = 'BV1xx411c7mD';
      const oid = 100;
      final comment = _comment(rpid: 21, like: 4);
      final port = _FakeVideoCommentPort(
        commentResponses: [
          CommentResponse(replies: [comment]),
        ],
      );
      final provider = videoCommentsControllerProvider(bvid);
      final container = ProviderContainer(
        overrides: [
          videoDetailControllerProvider(
            bvid,
          ).overrideWithValue(_videoDetailState(bvid: bvid, aid: oid)),
          videoCommentPortProvider.overrideWithValue(port),
          videoRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'videoRepositoryProvider should not be read by comments UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(provider, (_, _) {});
      addTearDown(subscription.close);

      final notifier = container.read(provider.notifier);

      await notifier.ensureLoaded();

      expect(port.fetchCommentsCalls.single, (oid: oid, sort: CommentSort.hot, page: 1));
      expect(container.read(provider).paging.items, [comment]);

      await notifier.toggleCommentLike(oid, comment.rpid, false);

      expect(port.likeCalls.single, (oid: oid, rpid: comment.rpid, isLiked: true));
      expect(container.read(provider).paging.items.single.like, 5);

      await notifier.toggleCommentDislike(oid, comment.rpid);

      expect(port.dislikeCalls.single, (oid: oid, rpid: comment.rpid, isDisliked: true));
    },
  );
}

Future<void> _waitForCommentReplyItems(
  ProviderContainer container,
  CommentReplyControllerProvider provider,
) async {
  for (var attempt = 0; attempt < 10; attempt++) {
    if (container.read(provider).paging.items.isNotEmpty) {
      return;
    }
    await pumpEventQueue();
  }
}

final class _FakeVideoCommentPort implements VideoCommentPort {
  _FakeVideoCommentPort({
    this.commentResponses = const [],
    this.replyResponses = const [],
  });

  final List<CommentResponse> commentResponses;
  final List<CommentResponse> replyResponses;
  final fetchCommentsCalls = <({int oid, CommentSort sort, int page})>[];
  final fetchReplyCalls = <({int oid, int root, int page})>[];
  final likeCalls = <({int oid, int rpid, bool isLiked})>[];
  final dislikeCalls = <({int oid, int rpid, bool isDisliked})>[];
  final replyCalls = <({int oid, int root, int parent, String message})>[];

  @override
  Future<Result<CommentResponse, AppError>> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
    CancelToken? cancelToken,
  }) async {
    fetchCommentsCalls.add((oid: oid, sort: sort, page: page));
    return Success(_responseAt(commentResponses, fetchCommentsCalls.length - 1));
  }

  @override
  Future<Result<CommentResponse, AppError>> fetchReply({
    required int oid,
    required int root,
    int page = 1,
    CancelToken? cancelToken,
  }) async {
    fetchReplyCalls.add((oid: oid, root: root, page: page));
    return Success(_responseAt(replyResponses, fetchReplyCalls.length - 1));
  }

  @override
  Future<Result<void, AppError>> setCommentLike({
    required int oid,
    required int rpid,
    required bool isLiked,
  }) async {
    likeCalls.add((oid: oid, rpid: rpid, isLiked: isLiked));
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> setCommentDislike({
    required int oid,
    required int rpid,
    bool isDisliked = true,
  }) async {
    dislikeCalls.add((oid: oid, rpid: rpid, isDisliked: isDisliked));
    return const Success(null);
  }

  @override
  Future<Result<CommentItem, AppError>> replyToComment({
    required int oid,
    required int root,
    required int parent,
    required String message,
  }) async {
    replyCalls.add((oid: oid, root: root, parent: parent, message: message));
    return Success(_comment(rpid: parent + 1, oid: oid, root: root, parent: parent));
  }
}

CommentResponse _responseAt(List<CommentResponse> responses, int index) {
  if (responses.isEmpty) {
    return const CommentResponse();
  }
  return responses[index.clamp(0, responses.length - 1)];
}

CommentItem _comment({
  required int rpid,
  int oid = 100,
  int root = 0,
  int parent = 0,
  int like = 0,
}) {
  return CommentItem(
    rpid: rpid,
    oid: oid,
    type: 1,
    mid: 200,
    root: root,
    parent: parent,
    ctime: 0,
    like: like,
    member: const CommentMember(
      mid: '200',
      uname: 'user',
      sex: '',
      sign: '',
      avatar: '',
      rank: '',
      levelInfo: CommentLevelInfo(
        currentLevel: 0,
        currentMin: 0,
        currentExp: 0,
        nextExp: 0,
      ),
      pendant: CommentPendant(pid: 0, name: '', image: '', expire: 0),
      nameplate: CommentNameplate(
        nid: 0,
        name: '',
        image: '',
        imageSmall: '',
        level: '',
        condition: '',
      ),
      officialVerify: OfficialVerify(),
      vip: CommentVip(),
    ),
    content: const CommentContent(message: ''),
  );
}

VideoDetailState _videoDetailState({required String bvid, required int aid}) {
  return VideoDetailState(
    isLoading: false,
    videoDetail: VideoDetailViewData(
      bvid: bvid,
      aid: aid,
      title: 'Video',
      pic: '',
      pubDate: 0,
      desc: '',
      owner: const VideoOwner(mid: 1, name: 'Uploader'),
      stat: const VideoStat(),
    ),
  );
}
