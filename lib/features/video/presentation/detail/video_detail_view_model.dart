import 'dart:async';
import 'dart:developer' as developer;

import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/services/relation_service.dart';
import 'package:culcul/features/video/application/models/play_url.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/features/video/application/video_detail_workflows.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_detail_view_model.freezed.dart';
part 'video_detail_view_model.g.dart';

@freezed
sealed class VideoDetailState with _$VideoDetailState {
  const factory VideoDetailState({
    @Default(true) bool isLoading,
    VideoDetailViewData? videoDetail,
    PlayUrl? playUrl,
    AppError? error,
    @Default(0) int currentCid,
    @Default([]) List<VideoModel> relatedVideos,
    @Default(80) int selectedQuality,
    @Default(1.0) double playbackSpeed,
    @Default([]) List<int> availableQualities,
  }) = _VideoDetailState;
}

@riverpod
class VideoDetailController extends _$VideoDetailController {
  int _loadToken = 0;
  int _playUrlRequestToken = 0;
  final Map<String, PlayUrl> _playUrlSessionCache = <String, PlayUrl>{};
  CancelToken? _criticalLoadCancelToken;
  CancelToken? _playUrlLoadCancelToken;
  CancelToken? _auxiliaryLoadCancelToken;

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

    final cached =
        _playUrlSessionCache[_buildPlayUrlCacheKey(
          aid: detail.aid,
          cid: cid,
          qn: state.selectedQuality,
        )];
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

    final cached =
        _playUrlSessionCache[_buildPlayUrlCacheKey(
          aid: detail.aid,
          cid: state.currentCid,
          qn: qn,
        )];
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

    final wasFollowed = detail.reqUser.attention == 1;
    final nextAttention = wasFollowed ? 0 : 1;
    final previousDetail = detail;

    state = state.copyWith(
      videoDetail: detail.copyWith(
        reqUser: detail.reqUser.copyWith(attention: nextAttention),
      ),
    );

    final result = await ref
        .read(relationServiceProvider)
        .modifyRelation(mid: detail.owner.mid, isFollow: !wasFollowed);
    if (result.isFailure) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }

  Future<void> toggleVideoLike() async {
    final detail = state.videoDetail;
    if (detail == null) return;

    final nextLiked = detail.reqUser.like != 1;
    final previousDetail = detail;
    state = state.copyWith(videoDetail: _applyVideoLikeState(detail, isLiked: nextLiked));

    final result = await ref
        .read(videoRepositoryProvider)
        .setVideoLike(aid: detail.aid, isLiked: nextLiked);
    if (result.isFailure) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }

  Future<void> addVideoCoin() async {
    final detail = state.videoDetail;
    if (detail == null) return;

    final previousDetail = detail;
    state = state.copyWith(videoDetail: _applyVideoCoinState(detail));

    final result = await ref.read(videoRepositoryProvider).addVideoCoin(aid: detail.aid);
    if (result.isFailure) {
      state = state.copyWith(videoDetail: previousDetail);
    }
  }

  void setVideoFavoriteState({required bool isFavorite}) {
    final detail = state.videoDetail;
    if (detail == null) return;

    state = state.copyWith(
      videoDetail: _applyVideoFavoriteState(detail, isFavorite: isFavorite),
    );
  }

  Future<void> reportProgress(int progress) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    await ref
        .read(videoRepositoryProvider)
        .reportVideoProgress(aid: detail.aid, cid: state.currentCid, progress: progress);
  }

  Future<void> _loadPlayUrl({required int aid, required int cid, required int qn}) async {
    final cached =
        _playUrlSessionCache[_buildPlayUrlCacheKey(aid: aid, cid: cid, qn: qn)];
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

  Future<void> _loadAuxiliaryData({required int requestToken}) async {
    _auxiliaryLoadCancelToken?.cancel('video_auxiliary_replaced');
    final cancelToken = CancelToken();
    _auxiliaryLoadCancelToken = cancelToken;
    final result = await ref
        .read(loadVideoDetailWorkflowProvider)
        .loadAuxiliary(bvid, cancelToken: cancelToken);
    if (!ref.mounted || !_isCurrentLoadRequest(requestToken)) {
      return;
    }

    final auxiliary = result.dataOrNull;
    if (auxiliary == null) {
      return;
    }
    final detail = state.videoDetail;
    if (detail == null) {
      return;
    }

    state = state.copyWith(
      videoDetail: detail.copyWith(tags: auxiliary.tags),
      relatedVideos: auxiliary.relatedVideos,
    );
    assert(() {
      developer.log(
        'video_perf auxiliary_loaded bvid=$bvid related=${auxiliary.relatedVideos.length} tags=${auxiliary.tags.length}',
        name: 'video.performance',
      );
      return true;
    }());
  }

  String _buildPlayUrlCacheKey({required int aid, required int cid, required int qn}) {
    return '$aid:$cid:$qn';
  }

  void _cachePlayUrl({
    required int aid,
    required int cid,
    required int qn,
    required PlayUrl playUrl,
  }) {
    _playUrlSessionCache[_buildPlayUrlCacheKey(aid: aid, cid: cid, qn: qn)] = playUrl;
  }

  bool _isCurrentLoadRequest(int requestToken) {
    return requestToken == _loadToken;
  }

  bool _isCurrentPlayUrlRequest(int requestToken) {
    return requestToken == _playUrlRequestToken;
  }
}

VideoDetailViewData _applyVideoLikeState(
  VideoDetailViewData detail, {
  required bool isLiked,
}) {
  final wasLiked = detail.reqUser.like == 1;
  final delta = isLiked == wasLiked ? 0 : (isLiked ? 1 : -1);
  final nextLike = (detail.stat.like + delta).clamp(0, 1 << 31);

  return detail.copyWith(
    reqUser: detail.reqUser.copyWith(like: isLiked ? 1 : 0),
    stat: detail.stat.copyWith(like: nextLike),
  );
}

VideoDetailViewData _applyVideoCoinState(VideoDetailViewData detail, {int count = 1}) {
  if (count <= 0) {
    return detail;
  }

  return detail.copyWith(
    reqUser: detail.reqUser.copyWith(coin: detail.reqUser.coin + count),
    stat: detail.stat.copyWith(coin: detail.stat.coin + count),
  );
}

VideoDetailViewData _applyVideoFavoriteState(
  VideoDetailViewData detail, {
  required bool isFavorite,
}) {
  final wasFavorite = detail.reqUser.favorite == 1;
  final delta = isFavorite == wasFavorite ? 0 : (isFavorite ? 1 : -1);
  final nextFavorite = (detail.stat.favorite + delta).clamp(0, 1 << 31);

  return detail.copyWith(
    reqUser: detail.reqUser.copyWith(favorite: isFavorite ? 1 : 0),
    stat: detail.stat.copyWith(favorite: nextFavorite),
  );
}
