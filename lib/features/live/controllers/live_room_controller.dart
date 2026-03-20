import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/features/live/controllers/live_room_state.dart';
import 'package:culcul/repositories/live_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/services/live_socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_controller.g.dart';

@riverpod
class LiveRoomController extends _$LiveRoomController {
  final LiveSocketService _socketService = LiveSocketService();

  @override
  LiveRoomState build(int roomId) {
    ref.onDispose(() {
      _socketService.dispose();
    });
    Future.microtask(() => _init(roomId));
    return LiveRoomState(roomId: roomId);
  }

  Future<void> _init(int roomId) async {
    state = state.copyWith(isLoading: true, error: null);

    // Add welcome message
    final welcomeItem = LiveDanmakuItem(
      text: '欢迎来到直播间~ 喜欢主播点个关注哦',
      nickname: '系统消息',
      uid: 0,
      dmType: 3, // System Notice
      guardLevel: 0,
      isadmin: 0,
      vip: 0,
      svip: 0,
      medal: [],
      userLevel: [],
    );
    state = state.copyWith(danmakuHistory: [welcomeItem]);

    // Fetch room info first to get real room_id if using short_id
    final infoResult = await ref
        .read(liveRepositoryProvider)
        .getRoomInfo(roomId);

    switch (infoResult) {
      case Success(value: final info):
        state = state.copyWith(roomInfo: info);
        // Load other data in parallel
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
      case Failure(exception: final e):
        state = state.copyWith(
          isLoading: false,
          error: e,
        );
    }
  }

  Future<void> _connectDanmaku(int roomId) async {
    final result = await ref.read(liveRepositoryProvider).getDanmuInfo(roomId);
    if (result case Success(value: final info)) {
      await _socketService.connect(info: info, roomId: roomId);
      _socketService.danmakuStream.listen((item) {
        // Prepend new item and limit list size to 500
        final newList = [item, ...state.danmakuHistory];
        if (newList.length > 500) {
          newList.removeRange(500, newList.length);
        }
        state = state.copyWith(danmakuHistory: newList);
      });
    }
  }

  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    final result = await ref.read(profileRepositoryProvider).modifyRelation(
      mid: int.parse(anchor.mid),
      isFollow: !isFollowing,
    );

    if (result is Success) {
      // Optimistic update if success
      state = state.copyWith(
        anchorInfo: anchor.copyWith(isFollowed: !isFollowing),
      );
    } else {
      // Show error? For now just keep state
    }
  }

  Future<void> _fetchPlayUrl(int roomId, {int? qn}) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getPlayUrl(roomId: roomId, qn: qn);
    if (result case Success(value: final url)) {
      state = state.copyWith(playUrl: url);
    }
  }

  Future<void> switchQuality(int qn) async {
    if (state.roomInfo == null) return;
    await _fetchPlayUrl(state.roomInfo!.roomId, qn: qn);
  }

  Future<void> _fetchAnchorInfo(int uid) async {
    final result = await ref.read(profileRepositoryProvider).getUserCard(uid);
    if (result case Success(value: final card)) {
      state = state.copyWith(anchorInfo: card);
    }
  }

  Future<void> _fetchLiveAnchorInfo(int uid) async {
    final result = await ref.read(liveRepositoryProvider).getAnchorInfo(uid);
    if (result case Success(value: final info)) {
      state = state.copyWith(liveAnchorInfo: info);
    }
  }

  Future<void> _fetchGoldRank(int roomId, int ruid) async {
    final result = await ref.read(liveRepositoryProvider).getOnlineGoldRank(
          roomId: roomId,
          ruid: ruid,
        );
    if (result case Success(value: final rank)) {
      state = state.copyWith(goldRank: rank);
    }
  }

  Future<void> _fetchGuardList(int roomId, int ruid) async {
    final result = await ref.read(liveRepositoryProvider).getGuardList(
          roomId: roomId,
          ruid: ruid,
        );
    if (result case Success(value: final list)) {
      state = state.copyWith(guardList: list);
    }
  }

  Future<void> _fetchDanmakuConfig(int roomId) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getDanmakuConfig(roomId);
    if (result case Success(value: final config)) {
      state = state.copyWith(danmakuConfig: config);
    }
  }

  Future<void> _fetchHistoryDanmaku(int roomId) async {
    final result = await ref
        .read(liveRepositoryProvider)
        .getHistoryDanmaku(roomId);
    if (result case Success(value: final history)) {
      // API returns history in chronological order (Oldest -> Newest).
      // We need to reverse it to Newest -> Oldest for ListView(reverse: true).
      state = state.copyWith(danmakuHistory: history.room.reversed.toList());
    }
  }

  void toggleDanmaku() {
    state = state.copyWith(isDanmakuEnabled: !state.isDanmakuEnabled);
  }

  Future<void> sendDanmaku(String msg) async {
    if (msg.trim().isEmpty) return;

    final result = await ref.read(liveRepositoryProvider).sendDanmaku(
          roomId: state.roomId,
          msg: msg,
        );

    if (result case Failure(exception: final _)) {
      // TODO: Show error
    }
  }

  Future<void> refresh() async {
    await _init(state.roomId);
  }
}
