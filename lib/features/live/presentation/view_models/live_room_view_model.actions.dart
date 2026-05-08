part of 'live_room_view_model.dart';

mixin _LiveRoomControllerActionsMixin
    on _$LiveRoomController, _LiveRoomControllerInitMixin {
  Future<void> toggleFollow() async {
    final anchor = state.anchorInfo;
    if (anchor == null) return;

    final isFollowing = anchor.isFollowed;
    final result = await ref.read(modifyRelationProvider)(
      mid: int.parse(anchor.mid),
      isFollow: !isFollowing,
    );
    if (result.isSuccess) {
      state = state.copyWith(anchorInfo: anchor.copyWith(isFollowed: !isFollowing));
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
