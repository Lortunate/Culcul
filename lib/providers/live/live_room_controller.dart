import 'package:culcul/core/types/result.dart';
import 'package:culcul/providers/live/live_room_state.dart';
import 'package:culcul/repositories/live_repository.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/services/live_socket_service.dart';
import 'package:culcul/core/errors/exceptions.dart';
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
    
    // Fetch room info first to get real room_id if using short_id
    final infoResult = await ref.read(liveRepositoryProvider).getRoomInfo(roomId);
    
    switch (infoResult) {
      case Success(value: final info):
        state = state.copyWith(roomInfo: info);
        // Load other data in parallel
        await Future.wait([
          _fetchPlayUrl(info.roomId),
          _fetchDanmakuConfig(info.roomId),
          _fetchHistoryDanmaku(info.roomId),
          _fetchAnchorInfo(info.uid),
          _connectDanmaku(info.roomId),
        ]);
        state = state.copyWith(isLoading: false);
      case Failure(exception: final e):
        state = state.copyWith(
          isLoading: false,
          error: e is AppException ? e : UnknownException(e.toString()),
        );
    }
  }

  Future<void> _connectDanmaku(int roomId) async {
    final result = await ref.read(liveRepositoryProvider).getDanmuInfo(roomId);
    if (result case Success(value: final info)) {
      await _socketService.connect(info: info, roomId: roomId);
      _socketService.danmakuStream.listen((item) {
        // Prepend new item (assuming list is Newest -> Oldest for reverse: true list)
        state = state.copyWith(
          danmakuHistory: [item, ...state.danmakuHistory],
        );
      });
    }
  }


  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    try {
      // Optimistic update
      state = state.copyWith(
        anchorInfo: anchor.copyWith(isFollowed: !isFollowing),
      );

      await ref.read(profileRepositoryProvider).modifyRelation(
            mid: int.parse(anchor.mid),
            isFollow: !isFollowing,
          );
    } catch (e) {
      // Revert on error
      state = state.copyWith(
        anchorInfo: anchor.copyWith(isFollowed: isFollowing),
      );
    }
  }

  Future<void> _fetchPlayUrl(int roomId, {int? qn}) async {
    final result = await ref.read(liveRepositoryProvider).getPlayUrl(roomId: roomId, qn: qn);
    if (result case Success(value: final url)) {
      state = state.copyWith(playUrl: url);
    }
  }

  Future<void> switchQuality(int qn) async {
    if (state.roomInfo == null) return;
    await _fetchPlayUrl(state.roomInfo!.roomId, qn: qn);
  }

  Future<void> _fetchAnchorInfo(int uid) async {
    try {
      final card = await ref.read(profileRepositoryProvider).getUserCard(uid.toString());
      state = state.copyWith(anchorInfo: card);
    } catch (e) {
      // Ignore error for anchor info, just don't show it or show partial info
    }
  }

  Future<void> _fetchDanmakuConfig(int roomId) async {
    final result = await ref.read(liveRepositoryProvider).getDanmakuConfig(roomId);
    if (result case Success(value: final config)) {
      state = state.copyWith(danmakuConfig: config);
    }
  }

  Future<void> _fetchHistoryDanmaku(int roomId) async {
    final result = await ref.read(liveRepositoryProvider).getHistoryDanmaku(roomId);
    if (result case Success(value: final history)) {
      // API returns history in chronological order (Oldest -> Newest).
      // We need to reverse it to Newest -> Oldest for ListView(reverse: true).
      state = state.copyWith(danmakuHistory: history.room.reversed.toList());
    }
  }
  
  void toggleDanmaku() {
    state = state.copyWith(isDanmakuEnabled: !state.isDanmakuEnabled);
  }
  
  Future<void> refresh() async {
    await _init(state.roomId);
  }
}
