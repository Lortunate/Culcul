import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/live/live_providers.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/features/live/domain/repositories/live_repository.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_workflows.g.dart';

@riverpod
LiveRoomWorkflows liveRoomWorkflows(Ref ref) {
  return LiveRoomWorkflows(
    liveRepository: ref.read(liveRepositoryProvider),
    profileRepository: ref.read(profileRepositoryProvider),
  );
}

class LiveRoomWorkflows {
  final LiveRepository liveRepository;
  final ProfileRepository profileRepository;

  const LiveRoomWorkflows({
    required this.liveRepository,
    required this.profileRepository,
  });

  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) async {
    return runResult(() => liveRepository.getRoomInfo(roomId));
  }

  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) async {
    return runResult(() => liveRepository.getDanmuInfo(roomId));
  }

  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({
    required int roomId,
    int? qn,
  }) async {
    return runResult(() => liveRepository.getPlayUrl(roomId: roomId, qn: qn));
  }

  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId) async {
    return runResult(() => liveRepository.getDanmakuConfig(roomId));
  }

  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) async {
    return runResult(() => liveRepository.getHistoryDanmaku(roomId));
  }

  Future<Result<UserCardModel, AppError>> getAnchorCard(int uid) async {
    return runResult(() => profileRepository.getUserCard(uid));
  }

  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid) async {
    return runResult(() => liveRepository.getAnchorInfo(uid));
  }

  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int roomId,
    required int uid,
  }) async {
    return runResult(
      () => liveRepository.getOnlineGoldRank(roomId: roomId, ruid: uid),
    );
  }

  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int roomId,
    required int uid,
  }) async {
    return runResult(() => liveRepository.getGuardList(roomId: roomId, ruid: uid));
  }

  Future<Result<void, AppError>> sendDanmaku({
    required int roomId,
    required String msg,
  }) async {
    return runVoidResult(() => liveRepository.sendDanmaku(roomId: roomId, msg: msg));
  }

  Future<Result<void, AppError>> toggleFollow({
    required int uid,
    required bool follow,
  }) async {
    return runVoidResult(() => profileRepository.modifyRelation(mid: uid, isFollow: follow));
  }

  Future<Result<List<LiveRoomSummary>, AppError>> getRecommendList(int page) async {
    return runResult(() => liveRepository.getRecommendList(page: page));
  }
}
