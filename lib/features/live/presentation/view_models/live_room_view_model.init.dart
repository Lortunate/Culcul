part of 'live_room_view_model.dart';

mixin _LiveRoomControllerInitMixin
    on _$LiveRoomController, _LiveRoomControllerFetchersMixin {
  int _beginLiveRoomRequest();
  @override
  bool _isActiveLiveRoomRequest(int requestToken);

  Future<void> _init(int roomId) async {
    final requestToken = _beginLiveRoomRequest();
    final firstInteractiveStopwatch = Stopwatch()..start();
    state = state.copyWith(isLoading: true, error: null);

    final welcomeItem = LiveDanmakuItem(
      text: t.live.danmaku.welcome,
      nickname: t.live.danmaku.system_notice,
      uid: 0,
      dmType: 3,
    );
    final danmakuFeed = _danmakuFeed(roomId);
    danmakuFeed.clear();
    danmakuFeed.seed([welcomeItem]);

    final roomInfoRequestStopwatch = Stopwatch()..start();
    final infoResult = await ref.read(liveRepositoryProvider).getRoomInfo(roomId);
    DevLogger.log('feature', 'live.room_init request', <String, Object?>{
      'segment': 'room_info',
      'roomId': roomId,
      'ms': roomInfoRequestStopwatch.elapsedMilliseconds,
      'success': infoResult.dataOrNull != null,
    });

    final info = infoResult.dataOrNull;
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    if (info == null) {
      state = state.copyWith(
        isLoading: false,
        error:
            infoResult.errorOrNull ?? const UnknownAppError('Failed to load room info'),
      );
      return;
    }
    state = state.copyWith(roomInfo: info);
    DevLogger.log('feature', 'live.room_init parse', <String, Object?>{
      'segment': 'room_info',
      'roomId': roomId,
      'anchorUid': info.uid,
    });

    final criticalRequestStopwatch = Stopwatch()..start();
    final criticalResults = await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<AppError?>(
          label: 'play_url',
          critical: false,
          fallback: (error) => error,
          task: () =>
              _fetchPlayUrl(info.roomId, critical: true, requestToken: requestToken),
        ),
        ConcurrentTask<AppError?>(
          label: 'danmaku_config',
          critical: false,
          fallback: (error) => error,
          task: () => _fetchDanmakuConfig(
            info.roomId,
            critical: true,
            requestToken: requestToken,
          ),
        ),
      ],
      profile: NetworkConcurrencyProfile.enrich,
      scope: 'live_room_init_critical',
    );
    final criticalError =
        criticalResults['play_url'] as AppError? ??
        criticalResults['danmaku_config'] as AppError?;
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    if (criticalError != null) {
      DevLogger.log('feature', 'live.room_init request', <String, Object?>{
        'segment': 'critical_group',
        'roomId': roomId,
        'ms': criticalRequestStopwatch.elapsedMilliseconds,
        'success': false,
      });
      state = state.copyWith(isLoading: false, error: criticalError);
      return;
    }
    DevLogger.log('feature', 'live.room_init request', <String, Object?>{
      'segment': 'critical_group',
      'roomId': roomId,
      'ms': criticalRequestStopwatch.elapsedMilliseconds,
      'success': true,
    });

    state = state.copyWith(isLoading: false, error: null);
    DevLogger.log('feature', 'live.room_init state_commit', <String, Object?>{
      'roomId': roomId,
      'hasPlayUrl': state.playUrl != null,
      'hasDanmakuConfig': state.danmakuConfig != null,
    });
    DevLogger.log('feature', 'live.room_init first_interactive', <String, Object?>{
      'roomId': roomId,
      'ms': firstInteractiveStopwatch.elapsedMilliseconds,
    });
    unawaited(_loadOptionalRoomData(info, requestToken: requestToken));
  }

  Future<void> _loadOptionalRoomData(
    LiveRoomDetailModel info, {
    required int requestToken,
  }) async {
    final optionalRequestStopwatch = Stopwatch()..start();
    await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<Object?>(
          label: 'history_danmaku',
          critical: false,
          fallback: _ignoreOptionalFailure,
          task: () async {
            await _fetchHistoryDanmaku(info.roomId, requestToken: requestToken);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'anchor_info',
          critical: false,
          fallback: _ignoreOptionalFailure,
          task: () async {
            await _fetchAnchorInfo(info.uid, requestToken: requestToken);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'live_anchor_info',
          critical: false,
          fallback: _ignoreOptionalFailure,
          task: () async {
            await _fetchLiveAnchorInfo(info.uid, requestToken: requestToken);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'gold_rank',
          critical: false,
          fallback: _ignoreOptionalFailure,
          task: () async {
            await _fetchGoldRank(info.roomId, info.uid, requestToken: requestToken);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'guard_list',
          critical: false,
          fallback: _ignoreOptionalFailure,
          task: () async {
            await _fetchGuardList(info.roomId, info.uid, requestToken: requestToken);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'connect_danmaku',
          critical: false,
          fallback: _ignoreOptionalFailure,
          task: () async {
            await _connectDanmaku(info.roomId, requestToken: requestToken);
            return null;
          },
        ),
      ],
      profile: NetworkConcurrencyProfile.backgroundSync,
      scope: 'live_room_init_optional',
    );
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    DevLogger.log('feature', 'live.room_init request', <String, Object?>{
      'segment': 'optional_group',
      'roomId': info.roomId,
      'ms': optionalRequestStopwatch.elapsedMilliseconds,
    });
  }

  Object? _ignoreOptionalFailure(Object _) {
    return null;
  }
}
