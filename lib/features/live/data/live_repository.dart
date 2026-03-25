import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/core/result.dart';
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

  Future<Result<LiveRoomDetailModel, AppException>> getRoomInfo(int roomId) async {
    return safeApiCall(() => _api.getRoomInfo(roomId));
  }

  Future<Result<LivePlayUrlModel, AppException>> getPlayUrl({
    required int roomId,
    int? qn,
    String platform = 'web',
  }) async {
    return safeApiCall(() => _api.getPlayUrl(roomId: roomId, qn: qn, platform: platform));
  }

  Future<Result<LiveDanmakuConfigModel, AppException>> getDanmakuConfig(
    int roomId,
  ) async {
    return safeApiCall(() => _api.getDanmakuConfig(roomId));
  }

  Future<Result<LiveHistoryDanmakuModel, AppException>> getHistoryDanmaku(
    int roomId,
  ) async {
    return safeApiCall(() => _api.getHistoryDanmaku(roomId));
  }

  Future<Result<LiveDanmuInfoModel, AppException>> getDanmuInfo(int roomId) async {
    return safeApiCall(() => _api.getDanmuInfo(roomId, 0));
  }

  Future<Result<List<LiveRoomModel>, AppException>> fetchRecommendList({
    int page = 1,
    int pageSize = 30,
  }) async {
    final result = await safeApiCall(
      () => _api.getRecommendList(page: page, pageSize: pageSize),
    );

    return switch (result) {
      Success(value: final data) => Success(data.roomList),
      Failure(exception: final e) => Failure(e),
    };
  }

  Future<Result<LiveAnchorInfoModel, AppException>> getAnchorInfo(int uid) async {
    return safeApiCall(() => _api.getAnchorInfo(uid));
  }

  Future<Result<LiveGoldRankModel, AppException>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    return safeApiCall(
      () => _api.getOnlineGoldRank(
        ruid: ruid,
        roomId: roomId,
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  Future<Result<LiveGuardListModel, AppException>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
    int pageSize = 20,
  }) async {
    return safeApiCall(
      () => _api.getGuardList(ruid: ruid, roomId: roomId, page: page, pageSize: pageSize),
    );
  }

  Future<Result<void, AppException>> sendDanmaku({
    required int roomId,
    required String msg,
  }) async {
    return safeVoidApiCall(
      () => _api.sendDanmaku(
        msg: msg,
        roomId: roomId,
        rnd: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
  }
}

