import 'package:culcul/features/live/data/dtos/live_anchor_info_model.dart';
import 'package:culcul/features/live/data/dtos/live_danmaku_model.dart';
import 'package:culcul/features/live/data/dtos/live_gold_rank_model.dart';
import 'package:culcul/features/live/data/dtos/live_guard_list_model.dart';
import 'package:culcul/features/live/data/dtos/live_play_url_model.dart';
import 'package:culcul/features/live/data/dtos/live_room_detail_model.dart';
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
