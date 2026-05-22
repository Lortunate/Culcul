import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/live/data/live_api.dart';
import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/live/application/models/live_anchor_info_model.dart';
import 'package:culcul/features/live/application/models/live_danmaku_model.dart';
import 'package:culcul/features/live/application/models/live_danmu_info_model.dart';
import 'package:culcul/features/live/application/models/live_gold_rank_model.dart';
import 'package:culcul/features/live/application/models/live_guard_list_model.dart';
import 'package:culcul/features/live/application/models/live_play_url_model.dart';
import 'package:culcul/features/live/application/models/live_room_detail_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/data/dtos/live_danmu_info_dto.dart';
import 'package:culcul/features/live/data/dtos/live_gold_rank_dto.dart';
import 'package:culcul/features/live/data/dtos/live_guard_list_dto.dart';
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

  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.getDanmuInfo(roomId, 0),
    );
    return result.map(_mapLiveDanmuInfo);
  }

  Future<Result<List<LiveRoomSummary>, AppError>> fetchRecommendListModels({
    int page = 1,
    required int pageSize,
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.getRecommendList(page: page, pageSize: pageSize),
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
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.getOnlineGoldRank(ruid: ruid, roomId: roomId, page: page),
    );
    return result.map(_mapLiveGoldRank);
  }

  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int ruid,
    required int roomId,
    int page = 1,
  }) async {
    final result = await _requestExecutor.runApiDirect(
      () => _api.getGuardList(ruid: ruid, roomId: roomId, page: page),
    );
    return result.map(_mapLiveGuardList);
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
    return fetchRecommendListModels(page: page, pageSize: pageSize);
  }
}

LiveDanmuInfoModel _mapLiveDanmuInfo(LiveDanmuInfoDto dto) {
  return LiveDanmuInfoModel(
    token: dto.token,
    hostList: dto.hostList.map(_mapLiveDanmuHost).toList(growable: false),
  );
}

LiveDanmuHost _mapLiveDanmuHost(LiveDanmuHostDto dto) {
  return LiveDanmuHost(host: dto.host, wssPort: dto.wssPort, wsPort: dto.wsPort);
}

LiveGoldRankModel _mapLiveGoldRank(LiveGoldRankDto dto) {
  return LiveGoldRankModel(
    onlineNum: dto.onlineNum,
    list: dto.list.map(_mapLiveRankItem).toList(growable: false),
  );
}

LiveRankItem _mapLiveRankItem(LiveRankItemDto dto) {
  return LiveRankItem(
    userRank: dto.userRank,
    uid: dto.uid,
    name: dto.name,
    face: dto.face,
    score: dto.score,
    medalInfo: _mapLiveRankMedalInfo(dto.medalInfo),
    guardLevel: dto.guardLevel,
    wealthLevel: dto.wealthLevel,
  );
}

LiveRankMedalInfo _mapLiveRankMedalInfo(LiveRankMedalInfoDto dto) {
  return LiveRankMedalInfo(
    guardLevel: dto.guardLevel,
    medalColorStart: dto.medalColorStart,
    medalColorEnd: dto.medalColorEnd,
    medalColorBorder: dto.medalColorBorder,
    medalName: dto.medalName,
    level: dto.level,
    targetId: dto.targetId,
    isLight: dto.isLight,
  );
}

LiveGuardListModel _mapLiveGuardList(LiveGuardListDto dto) {
  return LiveGuardListModel(
    info: _mapLiveGuardInfo(dto.info),
    top3: dto.top3.map(_mapLiveGuardItem).toList(growable: false),
    list: dto.list.map(_mapLiveGuardItem).toList(growable: false),
  );
}

LiveGuardInfo _mapLiveGuardInfo(LiveGuardInfoDto dto) {
  return LiveGuardInfo(num: dto.num, page: dto.page, now: dto.now);
}

LiveGuardItem _mapLiveGuardItem(LiveGuardItemDto dto) {
  return LiveGuardItem(
    ruid: dto.ruid,
    rank: dto.rank,
    userInfo: _mapLiveGuardUserInfo(dto.userInfo),
    guardLevel: dto.guardLevel,
  );
}

LiveGuardUserInfo _mapLiveGuardUserInfo(LiveGuardUserInfoDto dto) {
  return LiveGuardUserInfo(
    uid: dto.uid,
    base: LiveGuardUserBase(name: dto.base.name, face: dto.base.face),
  );
}
