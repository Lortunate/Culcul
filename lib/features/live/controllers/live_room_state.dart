import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/data/models/user/user_card_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:culcul/core/errors/exceptions.dart';

part 'live_room_state.freezed.dart';

@freezed
sealed class LiveRoomState with _$LiveRoomState {
  const factory LiveRoomState({
    required int roomId,
    @Default(true) bool isLoading,
    AppException? error,
    LiveRoomDetailModel? roomInfo,
    UserCardModel? anchorInfo,
    LiveAnchorInfoModel? liveAnchorInfo,
    LiveGoldRankModel? goldRank,
    LiveGuardListModel? guardList,
    LivePlayUrlModel? playUrl,
    LiveDanmakuConfigModel? danmakuConfig,
    @Default([]) List<LiveDanmakuItem> danmakuHistory,
    @Default(false) bool isPlaying,
    @Default(1.0) double volume,
    @Default(false) bool isDanmakuEnabled,
  }) = _LiveRoomState;
}

