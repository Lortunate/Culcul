import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/live_api.dart';
import 'package:culcul/data/models/live/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_repository.g.dart';

@Riverpod(keepAlive: true)
LiveRepository liveRepository(Ref ref) {
  return LiveRepository(ref.watch(liveApiProvider));
}

class LiveRepository extends BaseRepository {
  final LiveApi _api;

  LiveRepository(this._api);

  Future<LiveRoomDetailModel> getRoomInfo(int roomId) async {
    return requestApi(() => _api.getRoomInfo(roomId));
  }

  Future<LivePlayUrlModel> getPlayUrl({
    required int roomId,
    int? qn,
    String platform = 'web',
  }) async {
    return requestApi(() => _api.getPlayUrl(roomId: roomId, qn: qn, platform: platform));
  }

  Future<LiveDanmakuConfigModel> getDanmakuConfig(
    int roomId,
  ) async {
    return requestApi(() => _api.getDanmakuConfig(roomId));
  }

  Future<LiveHistoryDanmakuModel> getHistoryDanmaku(
    int roomId,
  ) async {
    return requestApi(() => _api.getHistoryDanmaku(roomId));
  }

  Future<LiveDanmuInfoModel> getDanmuInfo(int roomId) async {
    return requestApi(() => _api.getDanmuInfo(roomId, 0));
  }

  Future<List<LiveRoomModel>> fetchRecommendList({
    int page = 1,
    int pageSize = 30,
  }) async {
    final data = await requestApi(
      () => _api.getRecommendList(page: page, pageSize: pageSize),
    );
    return data.roomList;
  }

  Future<LiveAnchorInfoModel> getAnchorInfo(int uid) async {
    return requestApi(() => _api.getAnchorInfo(uid));
  }

  Future<LiveGoldRankModel> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    return requestApi(
      () => _api.getOnlineGoldRank(
        ruid: ruid,
        roomId: roomId,
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  Future<LiveGuardListModel> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    return requestApi(
      () => _api.getGuardList(ruid: ruid, roomId: roomId, page: page, pageSize: pageSize),
    );
  }

  Future<void> sendDanmaku({
    required int roomId,
    required String msg,
  }) async {
    return requestVoid(
      () => _api.sendDanmaku(
        msg: msg,
        roomId: roomId,
        rnd: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
  }
}

