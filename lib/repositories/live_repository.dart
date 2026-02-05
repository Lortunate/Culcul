import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/live_api.dart';
import 'package:culcul/data/models/live/index.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_repository.g.dart';

@Riverpod(keepAlive: true)
LiveRepository liveRepository(Ref ref) {
  return LiveRepository(ref.watch(liveApiProvider));
}

class LiveRepository {
  final LiveApi _api;

  LiveRepository(this._api);

  Future<Result<LiveRoomDetailModel, Exception>> getRoomInfo(int roomId) async {
    try {
      final response = await _api.getRoomInfo(roomId);
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }

  Future<Result<LivePlayUrlModel, Exception>> getPlayUrl({
    required int roomId,
    int? qn,
    String platform = 'web',
  }) async {
    try {
      final response = await _api.getPlayUrl(
        roomId: roomId,
        qn: qn,
        platform: platform,
      );
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }

  Future<Result<LiveDanmakuConfigModel, Exception>> getDanmakuConfig(int roomId) async {
    try {
      final response = await _api.getDanmakuConfig(roomId);
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }

  Future<Result<LiveHistoryDanmakuModel, Exception>> getHistoryDanmaku(int roomId) async {
    try {
      final response = await _api.getHistoryDanmaku(roomId);
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }

  Future<Result<LiveDanmuInfoModel, Exception>> getDanmuInfo(int roomId) async {
    try {
      final response = await _api.getDanmuInfo(roomId, 0);
      if (response.code == 0 && response.data != null) {
        return Success(response.data!);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }

  Future<Result<List<LiveRoomModel>, Exception>> fetchRecommendList() async {
    try {
      final response = await _api.getRecommendList();
      if (response.code == 0 && response.data != null) {
        return Success(response.data!.roomList);
      } else {
        return Failure(ServerException(
          response.message,
          code: response.code,
        ));
      }
    } on DioException catch (e) {
      return Failure(dioExceptionToAppException(e));
    } catch (e) {
      return Failure(UnknownException(e.toString()));
    }
  }
}
