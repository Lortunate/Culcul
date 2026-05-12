import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/data/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/live/data/live_room_mapper.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/domain/repositories/live_repository.dart' as domain;
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/data/dtos/live_dtos.dart';
import 'package:culcul/features/live/domain/entities/live_history_danmaku_model.dart'
    as domain_danmaku;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_repository_impl.g.dart';

@Riverpod(keepAlive: true)
domain.LiveRepository liveRepository(Ref ref) {
  return LiveRepositoryImpl(LiveApi(ref.watch(dioClientProvider)));
}

class LiveRepositoryImpl with RequestExecutorBinding implements domain.LiveRepository {
  static const int _recommendPageSize = 30;
  static const int _rankPageSize = 20;
  final LiveApi _api;
  final RequestExecutor _requestExecutor;

  LiveRepositoryImpl(this._api, {RequestExecutor? requestExecutor})
    : _requestExecutor = requestExecutor ?? const RequestExecutor();

  @override
  RequestExecutor get requestExecutor => _requestExecutor;

  @override
  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) async {
    return requestApiResult(() => _api.getRoomInfo(roomId));
  }

  @override
  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({
    required int roomId,
    int? qn,
  }) async {
    return requestApiResult(() => _api.getPlayUrl(roomId: roomId, qn: qn));
  }

  @override
  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId) async {
    return requestApiResult(() => _api.getDanmakuConfig(roomId));
  }

  @override
  Future<Result<domain_danmaku.LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) async {
    final result = await requestApiResult(() => _api.getHistoryDanmaku(roomId));
    return result.map((data) => data.toDomain());
  }

  @override
  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) async {
    return requestApiResult(() => _api.getDanmuInfo(roomId, 0));
  }

  Future<Result<List<LiveRoomSummary>, AppError>> fetchRecommendListModels({
    int page = 1,
  }) async {
    final result = await requestApiResult(
      () => _api.getRecommendList(page: page, pageSize: _recommendPageSize),
    );
    return result.map((data) => data.roomList);
  }

  @override
  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid) async {
    return requestApiResult(() => _api.getAnchorInfo(uid));
  }

  @override
  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    return requestApiResult(
      () => _api.getOnlineGoldRank(
        ruid: ruid,
        roomId: roomId,
        page: page,
        pageSize: _rankPageSize,
      ),
    );
  }

  @override
  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    return requestApiResult(
      () => _api.getGuardList(
        ruid: ruid,
        roomId: roomId,
        page: page,
        pageSize: _rankPageSize,
      ),
    );
  }

  @override
  Future<Result<void, AppError>> sendDanmaku({
    required int roomId,
    required String msg,
  }) async {
    return requestVoidResult(
      () => _api.sendDanmaku(
        msg: msg,
        roomId: roomId,
        rnd: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
  }

  @override
  Future<Result<List<LiveRoomSummary>, AppError>> getRecommendList({int page = 1}) async {
    return fetchRecommendListModels(page: page);
  }
}
