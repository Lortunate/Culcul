import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_room_state.freezed.dart';

@freezed
sealed class LiveRoomState with _$LiveRoomState {
  const factory LiveRoomState({
    required int roomId,
    @Default(true) bool isLoading,
    AppError? error,
    LiveRoomDetailModel? roomInfo,
    UserCardModel? anchorInfo,
    LiveAnchorInfoModel? liveAnchorInfo,
    LiveGoldRankModel? goldRank,
    LiveGuardListModel? guardList,
    LivePlayUrlModel? playUrl,
    LiveDanmakuConfigModel? danmakuConfig,
    @Default(false) bool isPlaying,
    @Default(1.0) double volume,
  }) = _LiveRoomState;
}
