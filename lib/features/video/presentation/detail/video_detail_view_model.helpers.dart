part of 'video_detail_view_model.dart';

mixin _VideoDetailControllerHelpersMixin on _$VideoDetailController {
  int get loadToken;
  int get playUrlRequestToken;
  Map<String, PlayUrl> get playUrlSessionCache;
  CancelToken? get auxiliaryLoadCancelToken;
  set auxiliaryLoadCancelToken(CancelToken? value);

  Future<void> reportProgress(int progress) async {
    final detail = state.videoDetail;
    if (detail == null) return;

    await ref
        .read(videoRepositoryProvider)
        .reportVideoProgress(aid: detail.aid, cid: state.currentCid, progress: progress);
  }

  Future<void> _loadAuxiliaryData({required int requestToken}) async {
    auxiliaryLoadCancelToken?.cancel('video_auxiliary_replaced');
    final cancelToken = CancelToken();
    auxiliaryLoadCancelToken = cancelToken;
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
      videoDetail: detail.copyWith(tag: auxiliary.tags),
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

  PlayUrl? _readCachedPlayUrl({required int aid, required int cid, required int qn}) {
    return playUrlSessionCache[_buildPlayUrlCacheKey(aid: aid, cid: cid, qn: qn)];
  }

  void _cachePlayUrl({
    required int aid,
    required int cid,
    required int qn,
    required PlayUrl playUrl,
  }) {
    playUrlSessionCache[_buildPlayUrlCacheKey(aid: aid, cid: cid, qn: qn)] = playUrl;
  }

  bool _isCurrentLoadRequest(int requestToken) {
    return requestToken == loadToken;
  }

  bool _isCurrentPlayUrlRequest(int requestToken) {
    return requestToken == playUrlRequestToken;
  }
}
