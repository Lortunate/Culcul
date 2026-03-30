import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/live/index.dart';
import 'package:culcul/data/models/user/user_card_model.dart';
import 'package:culcul/features/live/data/live_repository.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_room_use_cases.g.dart';

@riverpod
LiveRoomUseCases liveRoomUseCases(Ref ref) {
  return LiveRoomUseCases(
    liveRepository: ref.read(liveRepositoryProvider),
    profileRepository: ref.read(profileRepositoryProvider),
  );
}

class LiveRoomUseCases {
  final LiveRepository liveRepository;
  final ProfileRepository profileRepository;

  const LiveRoomUseCases({required this.liveRepository, required this.profileRepository});

  Future<Result<LiveRoomDetailModel, AppError>> getRoomInfo(int roomId) async {
    try {
      return Success(await liveRepository.getRoomInfo(roomId));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LiveDanmuInfoModel, AppError>> getDanmuInfo(int roomId) async {
    try {
      return Success(await liveRepository.getDanmuInfo(roomId));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LivePlayUrlModel, AppError>> getPlayUrl({
    required int roomId,
    int? qn,
  }) async {
    try {
      return Success(await liveRepository.getPlayUrl(roomId: roomId, qn: qn));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LiveDanmakuConfigModel, AppError>> getDanmakuConfig(int roomId) async {
    try {
      return Success(await liveRepository.getDanmakuConfig(roomId));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LiveHistoryDanmakuModel, AppError>> getHistoryDanmaku(int roomId) async {
    try {
      return Success(await liveRepository.getHistoryDanmaku(roomId));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<UserCardModel, AppError>> getAnchorCard(int uid) async {
    try {
      return Success(await profileRepository.getUserCard(uid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LiveAnchorInfoModel, AppError>> getAnchorInfo(int uid) async {
    try {
      return Success(await liveRepository.getAnchorInfo(uid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LiveGoldRankModel, AppError>> getOnlineGoldRank({
    required int roomId,
    required int uid,
  }) async {
    try {
      return Success(await liveRepository.getOnlineGoldRank(roomId: roomId, ruid: uid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<LiveGuardListModel, AppError>> getGuardList({
    required int roomId,
    required int uid,
  }) async {
    try {
      return Success(await liveRepository.getGuardList(roomId: roomId, ruid: uid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> sendDanmaku({
    required int roomId,
    required String msg,
  }) async {
    try {
      await liveRepository.sendDanmaku(roomId: roomId, msg: msg);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<void, AppError>> toggleFollow({
    required int uid,
    required bool follow,
  }) async {
    try {
      await profileRepository.modifyRelation(mid: uid, isFollow: follow);
      return const Success(null);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<LiveRoomModel>, AppError>> getRecommendList(int page) async {
    try {
      return Success(await liveRepository.fetchRecommendList(page: page));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
