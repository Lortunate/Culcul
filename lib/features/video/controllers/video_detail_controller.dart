import 'package:culcul/data/models/video/video_detail.dart';
import 'package:culcul/features/video/data/video_repository.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'video_detail_state.dart';

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

  Future<void> _fetchPlayUrl(int aid, int cid, {int qn = 80}) async {
    final repo = ref.read(videoRepositoryProvider);

    try {
      final playUrl = await repo.fetchVideoPlayUrl(aid: aid, cid: cid, quality: qn);
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

    final wasFollowed = detail.reqUser?.attention == 1;
    final nextAttention = wasFollowed ? 0 : 1;
    final previousDetail = detail;

    state = state.copyWith(
      videoDetail: detail.copyWith(
        reqUser:
            detail.reqUser?.copyWith(attention: nextAttention) ??
            ReqUser(attention: nextAttention),
      ),
    );

    try {
      await ref
          .read(relationRepositoryProvider)
          .modifyRelation(fid: detail.owner.mid, act: wasFollowed ? 2 : 1);
    } catch (_) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }
}
