part of 'live_room_view_model.dart';

mixin _LiveRoomControllerInitMixin
    on _$LiveRoomController, _LiveRoomControllerFetchersMixin {
  Future<void> _init(int roomId) async {
    final firstInteractiveStopwatch = Stopwatch()..start();
    state = state.copyWith(isLoading: true, error: null);

    final welcomeItem = LiveDanmakuItem(
      text: t.live.danmaku.welcome,
      nickname: t.live.danmaku.system_notice,
      uid: 0,
      dmType: 3,
      guardLevel: 0,
      isadmin: 0,
      vip: 0,
      svip: 0,
    );
    final danmakuFeed = _danmakuFeed(roomId);
    danmakuFeed.clear();
    danmakuFeed.seed([welcomeItem]);

    final roomInfoRequestStopwatch = Stopwatch()..start();
    final infoResult = await ref.read(liveRepositoryProvider).getRoomInfo(roomId);
    FeatureFlowPerfLogger.log(
      chain: 'live.room_init',
      stage: 'request',
      fields: <String, Object?>{
        'segment': 'room_info',
        'roomId': roomId,
        'ms': roomInfoRequestStopwatch.elapsedMilliseconds,
        'success': infoResult.dataOrNull != null,
      },
    );

    final info = infoResult.dataOrNull;
    if (info == null) {
      state = state.copyWith(
        isLoading: false,
        error:
            infoResult.errorOrNull ?? const UnknownAppError('Failed to load room info'),
      );
      return;
    }
    state = state.copyWith(roomInfo: info);
    FeatureFlowPerfLogger.log(
      chain: 'live.room_init',
      stage: 'parse',
      fields: <String, Object?>{
        'segment': 'room_info',
        'roomId': roomId,
        'anchorUid': info.uid,
      },
    );

    try {
      final criticalRequestStopwatch = Stopwatch()..start();
      await _concurrencyExecutor.runConcurrent(
        tasks: <ConcurrentTask<dynamic>>[
          ConcurrentTask<void>(
            label: 'play_url',
            critical: true,
            task: () => _fetchPlayUrl(info.roomId, critical: true),
          ),
          ConcurrentTask<void>(
            label: 'danmaku_config',
            critical: true,
            task: () => _fetchDanmakuConfig(info.roomId, critical: true),
          ),
        ],
        profile: NetworkConcurrencyProfile.enrich,
        scope: 'live_room_init_critical',
      );
      FeatureFlowPerfLogger.log(
        chain: 'live.room_init',
        stage: 'request',
        fields: <String, Object?>{
          'segment': 'critical_group',
          'roomId': roomId,
          'ms': criticalRequestStopwatch.elapsedMilliseconds,
          'success': true,
        },
      );
    } catch (error) {
      FeatureFlowPerfLogger.log(
        chain: 'live.room_init',
        stage: 'request',
        fields: <String, Object?>{
          'segment': 'critical_group',
          'roomId': roomId,
          'success': false,
        },
      );
      state = state.copyWith(isLoading: false, error: AppError.fromObject(error));
      return;
    }

    state = state.copyWith(isLoading: false, error: null);
    FeatureFlowPerfLogger.log(
      chain: 'live.room_init',
      stage: 'state_commit',
      fields: <String, Object?>{
        'roomId': roomId,
        'hasPlayUrl': state.playUrl != null,
        'hasDanmakuConfig': state.danmakuConfig != null,
      },
    );
    FeatureFlowPerfLogger.log(
      chain: 'live.room_init',
      stage: 'first_interactive',
      fields: <String, Object?>{
        'roomId': roomId,
        'ms': firstInteractiveStopwatch.elapsedMilliseconds,
      },
    );
    unawaited(_loadOptionalRoomData(info));
  }

  Future<void> _loadOptionalRoomData(LiveRoomDetailModel info) async {
    final optionalRequestStopwatch = Stopwatch()..start();
    await _concurrencyExecutor.runConcurrent(
      tasks: <ConcurrentTask<dynamic>>[
        ConcurrentTask<Object?>(
          label: 'history_danmaku',
          critical: false,
          fallback: (_) => null,
          task: () async {
            await _fetchHistoryDanmaku(info.roomId);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'anchor_info',
          critical: false,
          fallback: (_) => null,
          task: () async {
            await _fetchAnchorInfo(info.uid);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'live_anchor_info',
          critical: false,
          fallback: (_) => null,
          task: () async {
            await _fetchLiveAnchorInfo(info.uid);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'gold_rank',
          critical: false,
          fallback: (_) => null,
          task: () async {
            await _fetchGoldRank(info.roomId, info.uid);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'guard_list',
          critical: false,
          fallback: (_) => null,
          task: () async {
            await _fetchGuardList(info.roomId, info.uid);
            return null;
          },
        ),
        ConcurrentTask<Object?>(
          label: 'connect_danmaku',
          critical: false,
          fallback: (_) => null,
          task: () async {
            await _connectDanmaku(info.roomId);
            return null;
          },
        ),
      ],
      profile: NetworkConcurrencyProfile.backgroundSync,
      scope: 'live_room_init_optional',
    );
    FeatureFlowPerfLogger.log(
      chain: 'live.room_init',
      stage: 'request',
      fields: <String, Object?>{
        'segment': 'optional_group',
        'roomId': info.roomId,
        'ms': optionalRequestStopwatch.elapsedMilliseconds,
      },
    );
  }
}
