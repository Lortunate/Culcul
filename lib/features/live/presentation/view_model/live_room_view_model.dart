import 'dart:async';

import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/features/live/application/use_case/live_room_use_cases.dart';
import 'package:culcul/features/live/presentation/view_model/live_room_state.dart';
import 'package:culcul/features/live/data/live_socket_service.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_view_model.g.dart';

@riverpod
class LiveRoomController extends _$LiveRoomController {
  final LiveSocketService _socketService = LiveSocketService();

  @override
  LiveRoomState build(int roomId) {
    ref.onDispose(() {
      _socketService.dispose();
    });
    unawaited(_init(roomId));
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
      medal: [],
      userLevel: [],
    );
    state = state.copyWith(danmakuHistory: [welcomeItem]);

    try {
      final roomResult = await ref.read(liveRoomUseCasesProvider).getRoomInfo(roomId);
      final info = roomResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(roomInfo: info);
      await Future.wait([
        _fetchPlayUrl(info.roomId),
        _fetchDanmakuConfig(info.roomId),
        _fetchHistoryDanmaku(info.roomId),
        _fetchAnchorInfo(info.uid),
        _fetchLiveAnchorInfo(info.uid),
        _fetchGoldRank(info.roomId, info.uid),
        _fetchGuardList(info.roomId, info.uid),
        _connectDanmaku(info.roomId),
      ]);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      final exception = e is AppException ? e : UnknownException(e.toString(), cause: e);
      state = state.copyWith(isLoading: false, error: exception);
    }
  }

  Future<void> _connectDanmaku(int roomId) async {
    try {
      final danmuResult = await ref.read(liveRoomUseCasesProvider).getDanmuInfo(roomId);
      final info = danmuResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      await _socketService.connect(info: info, roomId: roomId);
      _socketService.danmakuStream.listen((item) {
        final newList = [item, ...state.danmakuHistory];
        if (newList.length > 500) {
          newList.removeRange(500, newList.length);
        }
        state = state.copyWith(danmakuHistory: newList);
      });
    } catch (error, stackTrace) {
      _logIgnoredError('connectDanmaku', error, stackTrace);
    }
  }

  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    try {
      final followResult = await ref
          .read(liveRoomUseCasesProvider)
          .toggleFollow(uid: int.parse(anchor.mid), follow: !isFollowing);
      if (followResult.isFailure) {
        throw followResult.errorOrNull!.toException();
      }
      state = state.copyWith(anchorInfo: anchor.copyWith(isFollowed: !isFollowing));
    } catch (error, stackTrace) {
      _logIgnoredError('toggleFollow', error, stackTrace);
    }
  }

  Future<void> _fetchPlayUrl(int roomId, {int? qn}) async {
    try {
      final playResult = await ref
          .read(liveRoomUseCasesProvider)
          .getPlayUrl(roomId: roomId, qn: qn);
      final url = playResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(playUrl: url);
    } catch (error, stackTrace) {
      _logIgnoredError('fetchPlayUrl', error, stackTrace);
    }
  }

  Future<void> switchQuality(int qn) async {
    if (state.roomInfo == null) return;
    await _fetchPlayUrl(state.roomInfo!.roomId, qn: qn);
  }

  Future<void> _fetchAnchorInfo(int uid) async {
    try {
      final cardResult = await ref.read(liveRoomUseCasesProvider).getAnchorCard(uid);
      final card = cardResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(anchorInfo: card);
    } catch (error, stackTrace) {
      _logIgnoredError('fetchAnchorInfo', error, stackTrace);
    }
  }

  Future<void> _fetchLiveAnchorInfo(int uid) async {
    try {
      final infoResult = await ref.read(liveRoomUseCasesProvider).getAnchorInfo(uid);
      final info = infoResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(liveAnchorInfo: info);
    } catch (error, stackTrace) {
      _logIgnoredError('fetchLiveAnchorInfo', error, stackTrace);
    }
  }

  Future<void> _fetchGoldRank(int roomId, int ruid) async {
    try {
      final rankResult = await ref
          .read(liveRoomUseCasesProvider)
          .getOnlineGoldRank(roomId: roomId, uid: ruid);
      final rank = rankResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(goldRank: rank);
    } catch (error, stackTrace) {
      _logIgnoredError('fetchGoldRank', error, stackTrace);
    }
  }

  Future<void> _fetchGuardList(int roomId, int ruid) async {
    try {
      final listResult = await ref
          .read(liveRoomUseCasesProvider)
          .getGuardList(roomId: roomId, uid: ruid);
      final list = listResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(guardList: list);
    } catch (error, stackTrace) {
      _logIgnoredError('fetchGuardList', error, stackTrace);
    }
  }

  Future<void> _fetchDanmakuConfig(int roomId) async {
    try {
      final configResult = await ref
          .read(liveRoomUseCasesProvider)
          .getDanmakuConfig(roomId);
      final config = configResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(danmakuConfig: config);
    } catch (error, stackTrace) {
      _logIgnoredError('fetchDanmakuConfig', error, stackTrace);
    }
  }

  Future<void> _fetchHistoryDanmaku(int roomId) async {
    try {
      final historyResult = await ref
          .read(liveRoomUseCasesProvider)
          .getHistoryDanmaku(roomId);
      final history = historyResult.when(
        success: (value) => value,
        failure: (error) => throw error.toException(),
      );
      state = state.copyWith(danmakuHistory: history.room.reversed.toList());
    } catch (error, stackTrace) {
      _logIgnoredError('fetchHistoryDanmaku', error, stackTrace);
    }
  }

  void toggleDanmaku() {
    state = state.copyWith(isDanmakuEnabled: !state.isDanmakuEnabled);
  }

  Future<void> sendDanmaku(String msg) async {
    if (msg.trim().isEmpty) return;

    try {
      final result = await ref
          .read(liveRoomUseCasesProvider)
          .sendDanmaku(roomId: state.roomId, msg: msg);
      if (result.isFailure) {
        throw result.errorOrNull!.toException();
      }
    } catch (error, stackTrace) {
      _logIgnoredError('sendDanmaku', error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _init(state.roomId);
  }

  void _logIgnoredError(String scope, Object error, StackTrace stackTrace) {
    debugPrint('LiveRoomController::$scope ignored error: $error\n$stackTrace');
  }
}
