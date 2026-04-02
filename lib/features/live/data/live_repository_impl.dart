import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/network/dio_client.dart';
import 'package:culcul/core/network/request_executor.dart';
import 'package:culcul/core/network/request_executor_binding.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/live/data/dtos/live_dtos.dart' as dto;
import 'package:culcul/features/live/data/live_room_mapper.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/features/live/domain/repositories/live_repository.dart' as domain;
import 'package:culcul/features/live/domain/entities/live_entities_exports.dart';
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
  Future<LiveRoomDetailModel> getRoomInfo(int roomId) async {
    final data = await requestApi(() => _api.getRoomInfo(roomId));
    return data.toDomain();
  }

  @override
  Future<LivePlayUrlModel> getPlayUrl({required int roomId, int? qn}) async {
    final data = await requestApi(() => _api.getPlayUrl(roomId: roomId, qn: qn));
    return data.toDomain();
  }

  @override
  Future<LiveDanmakuConfigModel> getDanmakuConfig(int roomId) async {
    final data = await requestApi(() => _api.getDanmakuConfig(roomId));
    return data.toDomain();
  }

  @override
  Future<LiveHistoryDanmakuModel> getHistoryDanmaku(int roomId) async {
    final data = await requestApi(() => _api.getHistoryDanmaku(roomId));
    return data.toDomain();
  }

  @override
  Future<LiveDanmuInfoModel> getDanmuInfo(int roomId) async {
    final data = await requestApi(() => _api.getDanmuInfo(roomId, 0));
    return data.toDomain();
  }

  Future<List<dto.LiveRoomModel>> fetchRecommendListModels({int page = 1}) async {
    final data = await requestApi(
      () => _api.getRecommendList(page: page, pageSize: _recommendPageSize),
    );
    return data.roomList;
  }

  @override
  Future<LiveAnchorInfoModel> getAnchorInfo(int uid) async {
    final data = await requestApi(() => _api.getAnchorInfo(uid));
    return data.toDomain();
  }

  @override
  Future<LiveGoldRankModel> getOnlineGoldRank({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    final data = await requestApi(
      () => _api.getOnlineGoldRank(
        ruid: ruid,
        roomId: roomId,
        page: page,
        pageSize: _rankPageSize,
      ),
    );
    return data.toDomain();
  }

  @override
  Future<LiveGuardListModel> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    final data = await requestApi(
      () => _api.getGuardList(
        ruid: ruid,
        roomId: roomId,
        page: page,
        pageSize: _rankPageSize,
      ),
    );
    return data.toDomain();
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
  Future<List<LiveRoomSummary>> getRecommendList({int page = 1}) async {
    return (await fetchRecommendListModels(
      page: page,
    )).map((item) => item.toSummary()).toList();
  }
}
