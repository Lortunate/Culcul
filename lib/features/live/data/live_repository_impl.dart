import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/data/dtos/live_anchor_info_model.dart';
import 'package:culcul/features/live/data/dtos/live_danmaku_model.dart';
import 'package:culcul/features/live/data/dtos/live_danmu_info_model.dart';
import 'package:culcul/features/live/data/dtos/live_gold_rank_model.dart';
import 'package:culcul/features/live/data/dtos/live_guard_list_model.dart';
import 'package:culcul/features/live/data/dtos/live_play_url_model.dart';
import 'package:culcul/features/live/data/dtos/live_room_detail_model.dart';
import 'package:culcul/features/live/data/dtos/live_history_danmaku_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_repository_impl.g.dart';

@Riverpod(keepAlive: true)
LiveRepositoryImpl liveRepository(Ref ref) {
  return LiveRepositoryImpl(LiveApi(ref.watch(dioClientProvider)));
}

class LiveRepositoryImpl {
  final LiveApi _api;
  final RequestExecutor _requestExecutor;

  LiveRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getRoomInfo(roomId));
  }

  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({required int roomId, int? qn}) {
    return _requestExecutor.runApiDirect(() => _api.getPlayUrl(roomId: roomId, qn: qn));
  }

  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getDanmakuConfig(roomId));
  }

  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getHistoryDanmaku(roomId));
  }

  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getDanmuInfo(roomId, 0));
  }

  Future<Result<List<LiveRoomSummary>, AppError>> fetchRecommendListModels({
    int page = 1,
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.getRecommendList(page: page),
    );
    return result.map((data) => data.roomList);
  }

  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid) {
    return _requestExecutor.runApiDirect(() => _api.getAnchorInfo(uid));
  }

  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
  }) {
    return _requestExecutor.runApiDirect(
      () => _api.getOnlineGoldRank(ruid: ruid, roomId: roomId, page: page),
    );
  }

  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  }) {
    return _requestExecutor.runApiDirect(
      () => _api.getGuardList(ruid: ruid, roomId: roomId, page: page),
    );
  }

  Future<Result<void, AppError>> sendDanmaku({required int roomId, required String msg}) {
    return _requestExecutor.runUnit(
      () => _api.sendDanmaku(
        msg: msg,
        roomId: roomId,
        rnd: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
  }

  Future<Result<List<LiveRoomSummary>, AppError>> getRecommendList({int page = 1}) {
    return fetchRecommendListModels(page: page);
  }
}
