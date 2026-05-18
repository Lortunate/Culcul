part of 'live_room_view_model.dart';

mixin _LiveRoomControllerFetchersMixin on _$LiveRoomController {
  LiveSocketService get _socketService;
  NetworkConcurrencyExecutor get _concurrencyExecutor;
  StreamSubscription<LiveDanmakuItem>? get _danmakuSubscription;
  set _danmakuSubscription(StreamSubscription<LiveDanmakuItem>? value);

  Future<void> _connectDanmaku(int roomId) async {
    final danmakuFeed = _danmakuFeed(roomId);
    final infoResult = await ref.read(liveRepositoryProvider).getDanmuInfo(roomId);
    final info = infoResult.dataOrNull;
    if (info == null) {
      danmakuFeed.setConnected(false);
      _logIgnoredError(
        'connectDanmaku',
        infoResult.errorOrNull ?? 'Unknown error',
        StackTrace.current,
      );
      return;
    }
    await _socketService.connect(info: info, roomId: roomId);
    danmakuFeed.setConnected(true);
    await _danmakuSubscription?.cancel();
    _danmakuSubscription = _socketService.danmakuStream.listen(
      danmakuFeed.enqueue,
      onError: (_, _) => danmakuFeed.setConnected(false),
      onDone: () => danmakuFeed.setConnected(false),
    );
  }

  Future<AppError?> _fetchPlayUrl(int roomId, {int? qn, bool critical = false}) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getPlayUrl(roomId: roomId, qn: qn);
    if (result.dataOrNull case final url?) {
      state = state.copyWith(playUrl: url);
      return null;
    }
    _logIgnoredError(
      'fetchPlayUrl',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
    if (critical) {
      return result.errorOrNull ?? const AppError.data('Failed to load live play url');
    }
    return null;
  }

  Future<void> _fetchAnchorInfo(int uid) async {
    final result = await ref.read(profileRepositoryProvider).getUserCard(uid);
    if (result.dataOrNull case final card?) {
      state = state.copyWith(anchorInfo: card);
      return;
    }
    _logIgnoredError(
      'fetchAnchorInfo',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
  }

  Future<void> _fetchLiveAnchorInfo(int uid) async {
    final result = await ref.read(liveRepositoryProvider).getAnchorInfo(uid);
    if (result.dataOrNull case final info?) {
      state = state.copyWith(liveAnchorInfo: info);
      return;
    }
    _logIgnoredError(
      'fetchLiveAnchorInfo',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
  }

  Future<void> _fetchGoldRank(int roomId, int ruid) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getOnlineGoldRank(roomId: roomId, ruid: ruid);
    if (result.dataOrNull case final rank?) {
      state = state.copyWith(goldRank: rank);
      return;
    }
    _logIgnoredError(
      'fetchGoldRank',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
  }

  Future<void> _fetchGuardList(int roomId, int ruid) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getGuardList(roomId: roomId, ruid: ruid);
    if (result.dataOrNull case final list?) {
      state = state.copyWith(guardList: list);
      return;
    }
    _logIgnoredError(
      'fetchGuardList',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
  }

  Future<AppError?> _fetchDanmakuConfig(int roomId, {bool critical = false}) async {
    final result = await ref.read(liveRepositoryProvider).getDanmakuConfig(roomId);
    if (result.dataOrNull case final config?) {
      state = state.copyWith(danmakuConfig: config);
      return null;
    }
    _logIgnoredError(
      'fetchDanmakuConfig',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
    if (critical) {
      return result.errorOrNull ??
          const AppError.data('Failed to load live danmaku config');
    }
    return null;
  }

  Future<void> _fetchHistoryDanmaku(int roomId) async {
    final result = await ref.read(liveRepositoryProvider).getHistoryDanmaku(roomId);
    if (result.dataOrNull case final history?) {
      _danmakuFeed(roomId).seed(history.room.reversed);
      return;
    }
    _logIgnoredError(
      'fetchHistoryDanmaku',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
  }

  void _logIgnoredError(String scope, Object error, StackTrace stackTrace) {
    debugPrint('LiveRoomController::$scope ignored error: $error\n$stackTrace');
  }

  LiveDanmakuFeedController _danmakuFeed(int roomId) {
    return ref.read(liveDanmakuFeedControllerProvider(roomId).notifier);
  }
}
