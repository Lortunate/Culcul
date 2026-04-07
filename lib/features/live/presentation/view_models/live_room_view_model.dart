import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/network/network_concurrency_executor.dart';
import 'package:culcul/core/network/network_concurrency_profiles.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/features/live/live.dart';
import 'package:culcul/features/live/presentation/view_models/live_socket_service.dart';
import 'package:culcul/features/profile/profile.dart';
import 'package:culcul/features/live/presentation/view_models/live_room_state.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_view_model.g.dart';

@riverpod
class LiveRoomController extends _$LiveRoomController {
  final LiveSocketService _socketService = LiveSocketService();
  final NetworkConcurrencyExecutor _concurrencyExecutor =
      const NetworkConcurrencyExecutor();
  StreamSubscription<LiveDanmakuItem>? _danmakuSubscription;

  @override
  LiveRoomState build(int roomId) {
    ref.onDispose(() {
      _danmakuSubscription?.cancel();
      _socketService.dispose();
    });
    unawaited(Future<void>.microtask(() => _init(roomId)));
    return LiveRoomState(roomId: roomId);
  }

  Future<void> _init(int roomId) async {
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

    final infoResult = await ref.read(liveRepositoryProvider).getRoomInfo(roomId);
    final info = infoResult.dataOrNull;
    if (info == null) {
      final error = infoResult.errorOrNull;
      state = state.copyWith(
        isLoading: false,
        error: error?.toException() ?? UnknownException('Failed to load room info'),
      );
      return;
    }
    state = state.copyWith(roomInfo: info);

    try {
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
    } catch (error) {
      state = state.copyWith(isLoading: false, error: _toAppException(error));
      return;
    }

    state = state.copyWith(isLoading: false, error: null);
    unawaited(_loadOptionalRoomData(info));
  }

  Future<void> _loadOptionalRoomData(LiveRoomDetailModel info) async {
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
  }

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

  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    final result = await ref
        .read(profileRepositoryProvider)
        .modifyRelation(mid: int.parse(anchor.mid), isFollow: !isFollowing);
    if (result.isSuccess) {
      state = state.copyWith(anchorInfo: anchor.copyWith(isFollowed: !isFollowing));
    } else {
      _logIgnoredError('toggleFollow', result.errorOrNull!, StackTrace.current);
    }
  }

  Future<void> _fetchPlayUrl(int roomId, {int? qn, bool critical = false}) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getPlayUrl(roomId: roomId, qn: qn);
    if (result.dataOrNull case final url?) {
      state = state.copyWith(playUrl: url);
      return;
    }
    _logIgnoredError(
      'fetchPlayUrl',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
    if (critical) {
      throw result.errorOrNull ?? AppError.data('Failed to load live play url');
    }
  }

  Future<void> switchQuality(int qn) async {
    if (state.roomInfo == null) return;
    await _fetchPlayUrl(state.roomInfo!.roomId, qn: qn);
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

  Future<void> _fetchDanmakuConfig(int roomId, {bool critical = false}) async {
    final result = await ref.read(liveRepositoryProvider).getDanmakuConfig(roomId);
    if (result.dataOrNull case final config?) {
      state = state.copyWith(danmakuConfig: config);
      return;
    }
    _logIgnoredError(
      'fetchDanmakuConfig',
      result.errorOrNull ?? 'Unknown error',
      StackTrace.current,
    );
    if (critical) {
      throw result.errorOrNull ?? AppError.data('Failed to load live danmaku config');
    }
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

  void _logIgnoredError(String scope, Object error, StackTrace stackTrace) {
    debugPrint('LiveRoomController::$scope ignored error: $error\n$stackTrace');
  }

  AppException _toAppException(Object error) {
    if (error is AppError) {
      return error.toException();
    }
    if (error is AppException) {
      return error;
    }
    return UnknownException(error.toString(), cause: error);
  }

  LiveDanmakuFeedController _danmakuFeed(int roomId) {
    return ref.read(liveDanmakuFeedControllerProvider(roomId).notifier);
  }
}
