import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'dart:async';

import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:culcul/features/video/application/video_detail_workflows.dart';
import 'package:culcul/features/video/video_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'video_detail_state.dart';

part 'video_detail_view_model.g.dart';

@riverpod
class VideoDetailController extends _$VideoDetailController {
  @override
  VideoDetailState build(String bvid) {
    unawaited(load());
    return const VideoDetailState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref.read(loadVideoDetailWorkflowProvider).call(bvid);
    state = result.when(
      success: (data) => state.copyWith(
        isLoading: false,
        videoDetail: data.detail,
        currentCid: data.currentCid,
        playUrl: data.playUrl,
        relatedVideos: data.relatedVideos,
        selectedQuality: data.selectedQuality,
        availableQualities: data.availableQualities,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }

  Future<void> switchPart(int cid) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    if (state.currentCid == cid && state.playUrl != null) return;

    state = state.copyWith(isLoading: true, currentCid: cid, playUrl: null);
    await _loadPlayUrl(aid: detail.aid, cid: cid, qn: state.selectedQuality);
  }

  Future<void> switchQuality(int qn) async {
    if (state.selectedQuality == qn) return;

    final detail = state.videoDetail;
    if (detail == null) return;

    state = state.copyWith(isLoading: true);
    await _loadPlayUrl(aid: detail.aid, cid: state.currentCid, qn: qn);
  }

  void setPlaybackSpeed(double speed) {
    state = state.copyWith(playbackSpeed: speed);
  }

  Future<void> reportProgress(int progress) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    await ref.read(videoRepositoryProvider).reportVideoProgress(
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

    final result = await runVoidResult(
      () => ref.read(relationRepositoryProvider).modifyRelation(
        fid: detail.owner.mid,
        act: wasFollowed ? 2 : 1,
      ),
    );
    if (result.isFailure) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }

  Future<void> _loadPlayUrl({required int aid, required int cid, required int qn}) async {
    final result = await runResult(
      () => ref.read(videoRepositoryProvider).fetchVideoPlayUrl(
        aid: aid,
        cid: cid,
        quality: qn,
      ),
    );
    state = result.when(
      success: (playUrl) => state.copyWith(
        playUrl: playUrl,
        isLoading: false,
        selectedQuality: playUrl.quality,
        availableQualities: playUrl.acceptQuality.toList(),
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }
}
