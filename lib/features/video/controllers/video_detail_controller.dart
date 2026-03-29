import 'package:culcul/core/utils/share_utils.dart';
import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/data/models/video/video_detail.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'video_detail_state.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';

part 'video_detail_controller.g.dart';

@riverpod
class VideoDetailController extends _$VideoDetailController {
  @override
  VideoDetailState build(String bvid) {
    Future.microtask(_init);
    return const VideoDetailState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true, error: null);

    final repo = ref.read(videoRepositoryProvider);
    try {
      final detail = await repo.fetchVideoView(bvid);
      int cid = 0;
      if (detail.pages.isNotEmpty) {
        cid = detail.pages.first.cid;
      }

      state = state.copyWith(videoDetail: detail, currentCid: cid);

      await Future.wait([
        _fetchRelatedVideos(),
        _fetchVideoTags(),
        _fetchComments(detail.aid),
        if (cid != 0) _fetchPlayUrl(detail.aid, cid),
      ]);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> _fetchRelatedVideos() async {
    final repo = ref.read(videoRepositoryProvider);
    try {
      final list = await repo.fetchRelatedVideos(bvid);
      state = state.copyWith(relatedVideos: list);
    } catch (_) {}
  }

  Future<void> _fetchVideoTags() async {
    final repo = ref.read(videoRepositoryProvider);
    if (state.videoDetail == null) return;

    try {
      final tags = await repo.fetchVideoTags(bvid);
      state = state.copyWith(videoDetail: state.videoDetail!.copyWith(tag: tags));
    } catch (_) {}
  }

  Future<void> _fetchComments(int aid) async {
    state = state.copyWith(
      isCommentLoading: true,
      comments: [],
      commentPage: 1,
      hasMoreComments: true,
    );

    final repo = ref.read(videoRepositoryProvider);
    try {
      final response = await repo.fetchComments(oid: aid, sort: state.commentSort, pn: 1);
      state = state.copyWith(
        comments: response.replies,
        commentPage: 2,
        hasMoreComments: response.replies.isNotEmpty,
        isCommentLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isCommentLoading: false);
    }
  }

  Future<void> loadMoreComments() async {
    if (state.isCommentLoading || !state.hasMoreComments) return;
    final detail = state.videoDetail;
    if (detail == null) return;

    state = state.copyWith(isCommentLoading: true);

    final repo = ref.read(videoRepositoryProvider);
    try {
      final response = await repo.fetchComments(
        oid: detail.aid,
        sort: state.commentSort,
        pn: state.commentPage,
      );
      state = state.copyWith(
        comments: [...state.comments, ...response.replies],
        commentPage: state.commentPage + 1,
        hasMoreComments: response.replies.isNotEmpty,
        isCommentLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isCommentLoading: false);
    }
  }

  Future<void> refreshComments() async {
    final detail = state.videoDetail;
    if (detail == null) return;
    await _fetchComments(detail.aid);
  }

  Future<void> switchCommentSort(int sort) async {
    if (state.commentSort == sort) return;
    final detail = state.videoDetail;
    if (detail == null) return;

    state = state.copyWith(
      commentSort: sort,
      comments: [],
      commentPage: 1,
      hasMoreComments: true,
      isCommentLoading: true,
    );

    final repo = ref.read(videoRepositoryProvider);
    try {
      final response = await repo.fetchComments(oid: detail.aid, sort: sort, pn: 1);
      state = state.copyWith(
        comments: response.replies,
        commentPage: 2,
        hasMoreComments: response.replies.isNotEmpty,
        isCommentLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isCommentLoading: false);
    }
  }

  Future<void> _fetchPlayUrl(int aid, int cid, {int qn = 80}) async {
    final repo = ref.read(videoRepositoryProvider);

    try {
      final playUrl = await repo.fetchVideoPlayUrl(aid: aid, cid: cid, qn: qn);
      final qualities = playUrl.acceptQuality.toList();
      state = state.copyWith(
        playUrl: playUrl,
        isLoading: false,
        selectedQuality: playUrl.quality,
        availableQualities: qualities,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> switchPart(int cid) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    if (state.currentCid == cid && state.playUrl != null) return;

    state = state.copyWith(isLoading: true, currentCid: cid, playUrl: null);
    await _fetchPlayUrl(detail.aid, cid, qn: state.selectedQuality);
  }

  Future<void> switchQuality(int qn) async {
    if (state.selectedQuality == qn) return;

    final detail = state.videoDetail;
    if (detail == null) return;

    state = state.copyWith(isLoading: true);
    await _fetchPlayUrl(detail.aid, state.currentCid, qn: qn);
  }

  void setPlaybackSpeed(double speed) {
    state = state.copyWith(playbackSpeed: speed);
  }

  Future<void> reportProgress(int progress) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    final repo = ref.read(videoRepositoryProvider);
    await repo.reportVideoProgress(
      aid: detail.aid,
      cid: state.currentCid,
      progress: progress,
    );
  }

  Future<void> toggleFollow() async {
    final detail = state.videoDetail;
    if (detail == null) return;

    final isFollowed = detail.reqUser?.attention == 1;
    final act = isFollowed ? 2 : 1;

    final newReqUser =
        detail.reqUser?.copyWith(attention: isFollowed ? 0 : 1) ??
        ReqUser(attention: isFollowed ? 0 : 1);

    state = state.copyWith(videoDetail: detail.copyWith(reqUser: newReqUser));

    final relationRepo = ref.read(relationRepositoryProvider);
    try {
      await relationRepo.modifyRelation(fid: detail.owner.mid, act: act);
    } catch (_) {
      state = state.copyWith(videoDetail: detail);
    }
  }

  Future<void> toggleLike() async {}

  Future<void> toggleDislike() async {}

  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {
    _updateCommentLikeStatus(rpid, !isLiked);

    final action = isLiked ? 0 : 1;
    final repo = ref.read(videoRepositoryProvider);
    try {
      await repo.actionComment(oid: oid, rpid: rpid, action: action);
    } catch (_) {
      _updateCommentLikeStatus(rpid, isLiked);
    }
  }

  Future<void> toggleCommentDislike(int oid, int rpid) async {
    final repo = ref.read(videoRepositoryProvider);
    await repo.hateComment(oid: oid, rpid: rpid, action: 1);
  }

  Future<void> addReply(int oid, int root, int parent, String message) async {
    final repo = ref.read(videoRepositoryProvider);
    await repo.addReply(oid: oid, root: root, parent: parent, message: message);
    await _fetchComments(oid);
  }

  void _updateCommentLikeStatus(int rpid, bool liked) {
    List<CommentItem> newComments = [];
    bool found = false;

    CommentItem updateItem(CommentItem item) {
      return item.copyWith(
        like: liked ? item.like + 1 : item.like - 1,
        action: liked ? 1 : 0,
      );
    }

    for (var comment in state.comments) {
      if (comment.rpid == rpid) {
        newComments.add(updateItem(comment));
        found = true;
      } else {
        final replyIndex = comment.replies.indexWhere((r) => r.rpid == rpid);
        if (replyIndex != -1) {
          final newReplies = List<CommentItem>.from(comment.replies);
          newReplies[replyIndex] = updateItem(newReplies[replyIndex]);
          newComments.add(comment.copyWith(replies: newReplies));
          found = true;
        } else {
          newComments.add(comment);
        }
      }
    }

    if (found) {
      state = state.copyWith(comments: newComments);
    }
  }

  Future<void> sendCoin({int multiply = 1}) async {}

  Future<void> toggleFavorite() async {}

  Future<void> share() async {
    final detail = state.videoDetail;
    if (detail == null) return;
    await ShareUtils.shareVideo(detail.bvid, detail.title, detail.pic);
  }
}
