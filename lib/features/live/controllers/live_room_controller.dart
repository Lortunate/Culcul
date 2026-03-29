import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/features/live/controllers/live_room_state.dart';
import 'package:culcul/features/live/data/live_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/features/live/data/live_socket_service.dart';
import 'package:culcul/i18n/strings.g.dart';
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
      final info = await ref.read(liveRepositoryProvider).getRoomInfo(roomId);
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
      final info = await ref.read(liveRepositoryProvider).getDanmuInfo(roomId);
      await _socketService.connect(info: info, roomId: roomId);
      _socketService.danmakuStream.listen((item) {
        final newList = [item, ...state.danmakuHistory];
        if (newList.length > 500) {
          newList.removeRange(500, newList.length);
        }
        state = state.copyWith(danmakuHistory: newList);
      });
    } catch (_) {
      // Ignore socket bootstrap errors for now.
    }
  }

  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    try {
      await ref
          .read(profileRepositoryProvider)
          .modifyRelation(mid: int.parse(anchor.mid), isFollow: !isFollowing);
      state = state.copyWith(anchorInfo: anchor.copyWith(isFollowed: !isFollowing));
    } catch (_) {
      // Keep current state when follow action fails.
    }
  }

  Future<void> _fetchPlayUrl(int roomId, {int? qn}) async {
    try {
      final url = await ref.read(liveRepositoryProvider).getPlayUrl(roomId: roomId, qn: qn);
      state = state.copyWith(playUrl: url);
    } catch (_) {}
  }

  Future<void> switchQuality(int qn) async {
    if (state.roomInfo == null) return;
    await _fetchPlayUrl(state.roomInfo!.roomId, qn: qn);
  }

  Future<void> _fetchAnchorInfo(int uid) async {
    try {
      final card = await ref.read(profileRepositoryProvider).getUserCard(uid);
      state = state.copyWith(anchorInfo: card);
    } catch (_) {}
  }

  Future<void> _fetchLiveAnchorInfo(int uid) async {
    try {
      final info = await ref.read(liveRepositoryProvider).getAnchorInfo(uid);
      state = state.copyWith(liveAnchorInfo: info);
    } catch (_) {}
  }

  Future<void> _fetchGoldRank(int roomId, int ruid) async {
    try {
      final rank = await ref
          .read(liveRepositoryProvider)
          .getOnlineGoldRank(roomId: roomId, ruid: ruid);
      state = state.copyWith(goldRank: rank);
    } catch (_) {}
  }

  Future<void> _fetchGuardList(int roomId, int ruid) async {
    try {
      final list = await ref
          .read(liveRepositoryProvider)
          .getGuardList(roomId: roomId, ruid: ruid);
      state = state.copyWith(guardList: list);
    } catch (_) {}
  }

  Future<void> _fetchDanmakuConfig(int roomId) async {
    try {
      final config = await ref.read(liveRepositoryProvider).getDanmakuConfig(roomId);
      state = state.copyWith(danmakuConfig: config);
    } catch (_) {}
  }

  Future<void> _fetchHistoryDanmaku(int roomId) async {
    try {
      final history = await ref.read(liveRepositoryProvider).getHistoryDanmaku(roomId);
      state = state.copyWith(danmakuHistory: history.room.reversed.toList());
    } catch (_) {}
  }

  void toggleDanmaku() {
    state = state.copyWith(isDanmakuEnabled: !state.isDanmakuEnabled);
  }

  Future<void> sendDanmaku(String msg) async {
    if (msg.trim().isEmpty) return;

    try {
      await ref.read(liveRepositoryProvider).sendDanmaku(roomId: state.roomId, msg: msg);
    } catch (_) {
      // TODO: Show error
    }
  }

  Future<void> refresh() async {
    await _init(state.roomId);
  }
}
