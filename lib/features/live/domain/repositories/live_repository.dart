import 'package:culcul/features/live/domain/entities/live_entities.dart';

abstract class LiveRepository {
  Future<LiveRoomDetailModel> getRoomInfo(int roomId);

  Future<LivePlayUrlModel> getPlayUrl({required int roomId, int? qn});

  Future<LiveDanmakuConfigModel> getDanmakuConfig(int roomId);

  Future<LiveHistoryDanmakuModel> getHistoryDanmaku(int roomId);

  Future<LiveDanmuInfoModel> getDanmuInfo(int roomId);

  Future<List<LiveRoomSummary>> getRecommendList({int page = 1, int pageSize = 30});

  Future<LiveAnchorInfoModel> getAnchorInfo(int uid);

  Future<LiveGoldRankModel> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  });

  Future<LiveGuardListModel> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  });

  Future<void> sendDanmaku({required int roomId, required String msg});
}
