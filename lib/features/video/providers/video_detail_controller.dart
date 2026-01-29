import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cilixili/data/models/video/index.dart';
import 'package:cilixili/data/repositories/video_repository.dart';
import 'package:cilixili/features/video/providers/video_detail_state.dart';

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
    try {
      final repo = ref.read(videoRepositoryProvider);
      final detail = await repo.fetchVideoView(bvid);

      int cid = 0;
      if (detail.pages.isNotEmpty) {
        cid = detail.pages.first.cid;
      }

      state = state.copyWith(videoDetail: detail, currentCid: cid);

      _fetchRelatedVideos();
      _fetchComments(detail.aid);

      if (cid != 0) {
        await _fetchPlayUrl(detail.aid, cid);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> _fetchRelatedVideos() async {
    try {
      final repo = ref.read(videoRepositoryProvider);
      final related = await repo.fetchRelatedVideos(bvid);
      state = state.copyWith(relatedVideos: related);
    } catch (_) {}
  }

  Future<void> _fetchComments(int aid) async {
    state = state.copyWith(
      isCommentLoading: true,
      comments: [],
      commentPage: 1,
      hasMoreComments: true,
    );
    try {
      final repo = ref.read(videoRepositoryProvider);
      final response = await repo.fetchComments(
        oid: aid,
        sort: state.commentSort,
        pn: 1,
      );
      state = state.copyWith(
        comments: response.replies,
        commentPage: 2,
        hasMoreComments: response.replies.isNotEmpty,
        isCommentLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isCommentLoading: false);
    }
  }

  Future<void> loadMoreComments() async {
    if (state.isCommentLoading || !state.hasMoreComments) return;
    final detail = state.videoDetail;
    if (detail == null) return;

    state = state.copyWith(isCommentLoading: true);
    try {
      final repo = ref.read(videoRepositoryProvider);
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
    } catch (e) {
      state = state.copyWith(isCommentLoading: false);
    }
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

    try {
      final repo = ref.read(videoRepositoryProvider);
      final response = await repo.fetchComments(
        oid: detail.aid,
        sort: sort,
        pn: 1,
      );
      state = state.copyWith(
        comments: response.replies,
        commentPage: 2,
        hasMoreComments: response.replies.isNotEmpty,
        isCommentLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isCommentLoading: false);
    }
  }

  Future<void> _fetchPlayUrl(int aid, int cid, {int qn = 80}) async {
    try {
      final repo = ref.read(videoRepositoryProvider);
      final playUrl = await repo.fetchVideoPlayUrl(aid: aid, cid: cid, qn: qn);

      final qualities = playUrl.acceptQuality.toList();
      state = state.copyWith(
        playUrl: playUrl,
        isLoading: false,
        selectedQuality: qn,
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

  Future<void> retry() async {
    await _init();
  }
}
