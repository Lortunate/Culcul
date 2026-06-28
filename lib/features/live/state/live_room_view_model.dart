import 'dart:async';

import 'package:culcul/core/models/user_card_contract.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/runtime/runtime_performance_policy_provider.dart';
import 'package:culcul/features/profile/relation_api.dart';
import 'package:culcul/features/live/application/danmaku/live_socket_service.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/application/models/live_play_url_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/features/live/data/live_repository_impl.dart';
import 'package:culcul/features/live/state/live_danmaku_feed_view_model.dart';
import 'package:culcul/features/profile/application/profile_session_providers.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_view_model.g.dart';

const Object _liveRoomStateUnset = Object();

class LiveRoomState {
  const LiveRoomState({
    required this.roomId,
    this.isLoading = true,
    this.error,
    this.roomInfo,
    this.anchorInfo,
    this.anchorLevel,
    this.goldRank,
    this.guardList,
    this.playUrl,
    this.isPlaying = false,
    this.volume = 1.0,
  });

  final int roomId;
  final bool isLoading;
  final AppError? error;
  final LiveRoomDetailModel? roomInfo;
  final UserCardModel? anchorInfo;
  final int? anchorLevel;
  final LiveGoldRankModel? goldRank;
  final LiveGuardListModel? guardList;
  final LivePlayUrlModel? playUrl;
  final bool isPlaying;
  final double volume;

  LiveRoomState copyWith({
    int? roomId,
    bool? isLoading,
    Object? error = _liveRoomStateUnset,
    Object? roomInfo = _liveRoomStateUnset,
    Object? anchorInfo = _liveRoomStateUnset,
    Object? anchorLevel = _liveRoomStateUnset,
    Object? goldRank = _liveRoomStateUnset,
    Object? guardList = _liveRoomStateUnset,
    Object? playUrl = _liveRoomStateUnset,
    bool? isPlaying,
    double? volume,
  }) {
    return LiveRoomState(
      roomId: roomId ?? this.roomId,
      isLoading: isLoading ?? this.isLoading,
      error: error == _liveRoomStateUnset ? this.error : error as AppError?,
      roomInfo: roomInfo == _liveRoomStateUnset
          ? this.roomInfo
          : roomInfo as LiveRoomDetailModel?,
      anchorInfo: anchorInfo == _liveRoomStateUnset
          ? this.anchorInfo
          : anchorInfo as UserCardModel?,
      anchorLevel: anchorLevel == _liveRoomStateUnset
          ? this.anchorLevel
          : anchorLevel as int?,
      goldRank: goldRank == _liveRoomStateUnset
          ? this.goldRank
          : goldRank as LiveGoldRankModel?,
      guardList: guardList == _liveRoomStateUnset
          ? this.guardList
          : guardList as LiveGuardListModel?,
      playUrl: playUrl == _liveRoomStateUnset
          ? this.playUrl
          : playUrl as LivePlayUrlModel?,
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveRoomState &&
            other.roomId == roomId &&
            other.isLoading == isLoading &&
            other.error == error &&
            other.roomInfo == roomInfo &&
            other.anchorInfo == anchorInfo &&
            other.anchorLevel == anchorLevel &&
            other.goldRank == goldRank &&
            other.guardList == guardList &&
            other.playUrl == playUrl &&
            other.isPlaying == isPlaying &&
            other.volume == volume;
  }

  @override
  int get hashCode => Object.hash(
    roomId,
    isLoading,
    error,
    roomInfo,
    anchorInfo,
    anchorLevel,
    goldRank,
    guardList,
    playUrl,
    isPlaying,
    volume,
  );
}

@riverpod
class LiveRoomController extends _$LiveRoomController {
  final LiveSocketService _socketService = LiveSocketService();
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();
  StreamSubscription<LiveDanmakuItem>? _danmakuSubscription;
  int _loadRequestToken = 0;
  bool _isDisposed = false;

  @override
  LiveRoomState build(int roomId) {
    _isDisposed = false;
    final runtimePolicy = ref.watch(runtimePerformancePolicyProvider);
    _socketService.applyRuntimePolicy(runtimePolicy);
    ref.onDispose(() {
      _isDisposed = true;
      _loadRequestToken++;
      _danmakuSubscription?.cancel();
      _socketService.dispose();
    });
    unawaited(Future<void>.microtask(() => _init(roomId)));
    return LiveRoomState(roomId: roomId);
  }

  bool _isActiveLiveRoomRequest(int requestToken) {
    return ref.mounted && !_isDisposed && requestToken == _loadRequestToken;
  }

  Future<void> _init(int roomId) async {
    final requestToken = ++_loadRequestToken;
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
      ],
      profile: NetworkConcurrencyProfile.enrich,
    );
    final criticalError = criticalResults['play_url'] as AppError?;
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
            await _fetchAnchorLevel(info.uid, requestToken: requestToken);
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

  Future<void> _connectDanmaku(int roomId, {required int requestToken}) async {
    final danmakuFeed = _danmakuFeed(roomId);
    final infoResult = await ref.read(liveRepositoryProvider).getDanmuInfo(roomId);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
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
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    await _socketService.connect(info: info, roomId: roomId);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    danmakuFeed.setConnected(true);
    await _danmakuSubscription?.cancel();
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    _danmakuSubscription = _socketService.danmakuStream.listen(
      danmakuFeed.enqueue,
      onError: (_, _) => danmakuFeed.setConnected(false),
      onDone: () => danmakuFeed.setConnected(false),
    );
  }

  Future<AppError?> _fetchPlayUrl(
    int roomId, {
    int? qn,
    bool critical = false,
    int? requestToken,
  }) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getPlayUrl(roomId: roomId, qn: qn);
    if (requestToken != null && !_isActiveLiveRoomRequest(requestToken)) {
      return null;
    }
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

  Future<void> _fetchAnchorInfo(int uid, {required int requestToken}) async {
    final result = await ref.read(userProfileCardProvider('$uid').future);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
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

  Future<void> _fetchAnchorLevel(int uid, {required int requestToken}) async {
    final result = await ref.read(liveRepositoryProvider).getAnchorInfo(uid);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
    if (result.dataOrNull case final level?) {
      state = state.copyWith(anchorLevel: level);
      return;
    }
    _logIgnoredError(
      'fetchAnchorLevel',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
  }

  Future<void> _fetchGoldRank(int roomId, int ruid, {required int requestToken}) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getOnlineGoldRank(roomId: roomId, ruid: ruid);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
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

  Future<void> _fetchGuardList(int roomId, int ruid, {required int requestToken}) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getGuardList(roomId: roomId, ruid: ruid);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
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

  Future<void> _fetchHistoryDanmaku(int roomId, {required int requestToken}) async {
    final result = await ref.read(liveRepositoryProvider).getHistoryDanmaku(roomId);
    if (!_isActiveLiveRoomRequest(requestToken)) {
      return;
    }
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
    DevLogger.log('live', 'room.fetch_ignored_error', <String, Object?>{
      'scope': scope,
      'error': error,
      'stack': stackTrace,
    });
  }

  LiveDanmakuFeedController _danmakuFeed(int roomId) {
    return ref.read(liveDanmakuFeedControllerProvider(roomId).notifier);
  }

  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    final result = await ref
        .read(relationServiceProvider)
        .modifyRelation(mid: int.parse(anchor.mid), isFollow: !isFollowing);
    if (result.isSuccess) {
      state = state.copyWith(
        anchorInfo: UserCardModel(
          mid: anchor.mid,
          name: anchor.name,
          face: anchor.face,
          isFollowed: !isFollowing,
        ),
      );
    } else {
      _logIgnoredError('toggleFollow', result.errorOrNull!, StackTrace.current);
    }
  }

  Future<void> switchQuality(int qn) async {
    if (state.roomInfo == null) return;
    await _fetchPlayUrl(state.roomInfo!.roomId, qn: qn);
  }

  void toggleDanmaku() {
    _danmakuFeed(state.roomId).toggleEnabled();
  }

  Future<void> sendDanmaku(String msg) async {
    if (msg.trim().isEmpty) return;

    final result = await ref
        .read(liveRepositoryProvider)
        .sendDanmaku(roomId: state.roomId, msg: msg);
    if (result.isFailure) {
      _logIgnoredError('sendDanmaku', result.errorOrNull!, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await _init(state.roomId);
  }
}
