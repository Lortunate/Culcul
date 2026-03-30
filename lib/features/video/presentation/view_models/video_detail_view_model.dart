import 'package:culcul/features/video/domain/entities/video_models.dart';
import 'dart:async';

import 'package:culcul/features/video/application/use_case/video_detail_use_cases.dart';
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
    final result = await ref.read(loadVideoDetailUseCaseProvider).call(bvid);
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

    await ref
        .read(reportVideoProgressUseCaseProvider)
        .call(
          ReportVideoProgressCommand(
            aid: detail.aid,
            cid: state.currentCid,
            progress: progress,
          ),
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

    final result = await ref
        .read(toggleVideoFollowUseCaseProvider)
        .call(
          ToggleVideoFollowCommand(followMid: detail.owner.mid, wasFollowed: wasFollowed),
        );
    if (result.isFailure) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }

  Future<void> _loadPlayUrl({required int aid, required int cid, required int qn}) async {
    final result = await ref
        .read(loadVideoPlayUrlUseCaseProvider)
        .call(VideoPlayUrlCommand(aid: aid, cid: cid, quality: qn));
    state = result.when(
      success: (data) => state.copyWith(
        playUrl: data.playUrl,
        isLoading: false,
        selectedQuality: data.selectedQuality,
        availableQualities: data.availableQualities,
      ),
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }
}
