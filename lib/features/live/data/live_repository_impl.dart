import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/utils/json_utils.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/application/models/live_danmu_info_model.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_play_url_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_repository_impl.g.dart';

@Riverpod(keepAlive: true)
LiveRepositoryImpl liveRepository(Ref ref) {
  return LiveRepositoryImpl(LiveApi(ref.watch(dioClientProvider)));
}

class LiveRepositoryImpl {
  final LiveApi _api;
  final RequestExecutor _requestExecutor;

  LiveRepositoryImpl(
    this._api, {
    RequestExecutor requestExecutor = const RequestExecutor(),
  }) : _requestExecutor = requestExecutor;

  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getRoomInfo(roomId));
  }

  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({required int roomId, int? qn}) {
    return _requestExecutor.runApiDirect(() => _api.getPlayUrl(roomId: roomId, qn: qn));
  }

  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getHistoryDanmaku(roomId));
  }

  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) {
    return _requestExecutor.runApiDirect(() => _api.getDanmuInfo(roomId, 0));
  }

  Future<Result<int, AppError>> getAnchorInfo(int uid) {
    return _requestExecutor.runApi<int, Object>(
      () => _api.getAnchorInfo(uid),
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final exp = JsonUtils.asStringKeyedMap(map?['exp']);
        final masterLevel = JsonUtils.asStringKeyedMap(exp?['master_level']);
        if (masterLevel == null || !masterLevel.containsKey('level')) {
          throw const FormatException('Missing anchor master level');
        }
        return JsonUtils.parseIntWithDefault(masterLevel['level']);
      },
    );
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

  Future<Result<List<LiveRoomSummary>, AppError>> getRecommendList({
    int page = 1,
    required int pageSize,
  }) {
    return _requestExecutor.runApi<List<LiveRoomSummary>, Object>(
      () => _api.getRecommendList(page: page, pageSize: pageSize),
      transform: (data) {
        final map = JsonUtils.asStringKeyedMap(data);
        final rooms = map?['recommend_room_list'];
        if (rooms is! List) {
          throw const FormatException('Missing recommend_room_list');
        }

        return rooms.map((room) {
          final roomJson = JsonUtils.asStringKeyedMap(room);
          if (roomJson == null) {
            throw const FormatException('Invalid recommend_room_list item');
          }
          return LiveRoomSummary.fromJson(roomJson);
        }).toList();
      },
    );
  }
}
