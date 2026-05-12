import 'dart:async';
import 'dart:developer' as developer;

import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:dio/dio.dart';
import 'package:culcul/core/session/relation_providers.dart';
import 'package:culcul/features/video/application/video_detail_workflows.dart';
import 'package:culcul/features/video/feature_scope.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'video_detail_state.dart';

part 'video_detail_view_model.g.dart';
part 'video_detail_view_model.helpers.dart';

@riverpod
class VideoDetailController extends _$VideoDetailController
    with _VideoDetailControllerHelpersMixin {
  int _loadToken = 0;
  int _playUrlRequestToken = 0;
  final Map<String, PlayUrl> _playUrlSessionCache = <String, PlayUrl>{};
  CancelToken? _criticalLoadCancelToken;
  CancelToken? _playUrlLoadCancelToken;
  CancelToken? _auxiliaryLoadCancelToken;

  @override
  int get loadToken => _loadToken;

  @override
  int get playUrlRequestToken => _playUrlRequestToken;

  @override
  Map<String, PlayUrl> get playUrlSessionCache => _playUrlSessionCache;

  @override
  CancelToken? get auxiliaryLoadCancelToken => _auxiliaryLoadCancelToken;

  @override
  set auxiliaryLoadCancelToken(CancelToken? value) {
    _auxiliaryLoadCancelToken = value;
  }

  @override
  VideoDetailState build(String bvid) {
    ref.onDispose(() {
      _criticalLoadCancelToken?.cancel('video_detail_disposed');
      _playUrlLoadCancelToken?.cancel('video_playurl_disposed');
      _auxiliaryLoadCancelToken?.cancel('video_auxiliary_disposed');
    });
    unawaited(Future<void>.microtask(load));
    return const VideoDetailState();
  }

  Future<void> load() async {
    final requestToken = ++_loadToken;
    _playUrlRequestToken++;
    _criticalLoadCancelToken?.cancel('video_detail_reloaded');
    _auxiliaryLoadCancelToken?.cancel('video_auxiliary_reloaded');
    _playUrlLoadCancelToken?.cancel('video_playurl_reloaded');
    final cancelToken = CancelToken();
    _criticalLoadCancelToken = cancelToken;
    state = state.copyWith(isLoading: true, error: null);
    final result = await ref
        .read(loadVideoDetailWorkflowProvider)
        .loadCritical(bvid, cancelToken: cancelToken);
    if (!ref.mounted || !_isCurrentLoadRequest(requestToken)) {
      return;
    }

    state = result.when(
      success: (data) {
        final playUrl = data.playUrl;
        if (playUrl != null) {
          _cachePlayUrl(
            aid: data.detail.aid,
            cid: data.currentCid,
            qn: playUrl.quality,
            playUrl: playUrl,
          );
        }
        return state.copyWith(
          isLoading: false,
          videoDetail: data.detail,
          currentCid: data.currentCid,
          playUrl: playUrl,
          selectedQuality: data.selectedQuality,
          availableQualities: data.availableQualities,
        );
      },
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );

    if (result.dataOrNull == null) {
      return;
    }
    unawaited(_loadAuxiliaryData(requestToken: requestToken));
  }

  Future<void> switchPart(int cid) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    if (state.currentCid == cid && state.playUrl != null) return;

    final cached = _readCachedPlayUrl(
      aid: detail.aid,
      cid: cid,
      qn: state.selectedQuality,
    );
    if (cached != null) {
      state = state.copyWith(
        isLoading: false,
        error: null,
        currentCid: cid,
        playUrl: cached,
        selectedQuality: cached.quality,
        availableQualities: cached.acceptQuality.toList(),
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, currentCid: cid, playUrl: null);
    await _loadPlayUrl(aid: detail.aid, cid: cid, qn: state.selectedQuality);
  }

  Future<void> switchQuality(int qn) async {
    if (state.selectedQuality == qn) return;

    final detail = state.videoDetail;
    if (detail == null) return;

    final cached = _readCachedPlayUrl(aid: detail.aid, cid: state.currentCid, qn: qn);
    if (cached != null) {
      state = state.copyWith(
        isLoading: false,
        error: null,
        playUrl: cached,
        selectedQuality: cached.quality,
        availableQualities: cached.acceptQuality.toList(),
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    await _loadPlayUrl(aid: detail.aid, cid: state.currentCid, qn: qn);
  }

  void setPlaybackSpeed(double speed) {
    if (state.playbackSpeed == speed) {
      return;
    }
    state = state.copyWith(playbackSpeed: speed);
    unawaited(ref.read(playerControllerProvider.notifier).setPlaybackRate(speed));
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

    final result = await ref.read(modifyRelationProvider)(
      mid: detail.owner.mid,
      isFollow: !wasFollowed,
    );
    if (result.isFailure) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }

  Future<void> _loadPlayUrl({required int aid, required int cid, required int qn}) async {
    final cached = _readCachedPlayUrl(aid: aid, cid: cid, qn: qn);
    if (cached != null) {
      state = state.copyWith(
        playUrl: cached,
        isLoading: false,
        error: null,
        selectedQuality: cached.quality,
        availableQualities: cached.acceptQuality.toList(),
      );
      return;
    }

    final requestToken = ++_playUrlRequestToken;
    _playUrlLoadCancelToken?.cancel('video_playurl_replaced');
    final cancelToken = CancelToken();
    _playUrlLoadCancelToken = cancelToken;
    final result = await ref
        .read(videoRepositoryProvider)
        .fetchVideoPlayUrl(aid: aid, cid: cid, quality: qn, cancelToken: cancelToken);
    if (!ref.mounted || !_isCurrentPlayUrlRequest(requestToken)) {
      return;
    }

    state = result.when(
      success: (playUrl) {
        _cachePlayUrl(aid: aid, cid: cid, qn: playUrl.quality, playUrl: playUrl);
        return state.copyWith(
          playUrl: playUrl,
          isLoading: false,
          error: null,
          selectedQuality: playUrl.quality,
          availableQualities: playUrl.acceptQuality.toList(),
        );
      },
      failure: (error) => state.copyWith(isLoading: false, error: error),
    );
  }
}
