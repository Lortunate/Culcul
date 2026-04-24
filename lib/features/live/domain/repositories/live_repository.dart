import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';

abstract class LiveRepository {
  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId);

  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({required int roomId, int? qn});

  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId);

  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId);

  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId);

  Future<Result<List<LiveRoomSummary>, AppError>> getRecommendList({int page = 1});

  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid);

  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
  });

  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  });

  Future<Result<void, AppError>> sendDanmaku({required int roomId, required String msg});
}
