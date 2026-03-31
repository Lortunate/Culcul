import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/features/live/data/mappers/live_room_mapper.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/domain/repositories/live_repository.dart' as domain;
import 'package:culcul/features/live/models/live_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_repository.g.dart';

@Riverpod(keepAlive: true)
domain.LiveRepository liveRepository(Ref ref) {
  return LiveRepositoryImpl(ref.watch(liveApiProvider));
}

class LiveRepositoryImpl extends BaseRepository implements domain.LiveRepository {
  final LiveApi _api;

  LiveRepositoryImpl(this._api);

  @override
  Future<LiveRoomDetailModel> getRoomInfo(int roomId) async {
    return requestApi(() => _api.getRoomInfo(roomId));
  }

  @override
  Future<LivePlayUrlModel> getPlayUrl({
    required int roomId,
    int? qn,
    String platform = 'web',
  }) async {
    return requestApi(() => _api.getPlayUrl(roomId: roomId, qn: qn, platform: platform));
  }

  @override
  Future<LiveDanmakuConfigModel> getDanmakuConfig(int roomId) async {
    return requestApi(() => _api.getDanmakuConfig(roomId));
  }

  @override
  Future<LiveHistoryDanmakuModel> getHistoryDanmaku(int roomId) async {
    return requestApi(() => _api.getHistoryDanmaku(roomId));
  }

  @override
  Future<LiveDanmuInfoModel> getDanmuInfo(int roomId) async {
    return requestApi(() => _api.getDanmuInfo(roomId, 0));
  }

  Future<List<LiveRoomModel>> fetchRecommendListModels({
    int page = 1,
    int pageSize = 30,
  }) async {
    final data = await requestApi(
      () => _api.getRecommendList(page: page, pageSize: pageSize),
    );
    return data.roomList;
  }

  @override
  Future<LiveAnchorInfoModel> getAnchorInfo(int uid) async {
    return requestApi(() => _api.getAnchorInfo(uid));
  }

  @override
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

  @override
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

  @override
  Future<void> sendDanmaku({required int roomId, required String msg}) async {
    return requestVoid(
      () => _api.sendDanmaku(
        msg: msg,
        roomId: roomId,
        rnd: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
  }

  @override
  Future<List<LiveRoomSummary>> getRecommendList({
    int page = 1,
    int pageSize = 30,
  }) async {
    return (await fetchRecommendListModels(
      page: page,
      pageSize: pageSize,
    )).map((item) => item.toDomain()).toList();
  }
}
