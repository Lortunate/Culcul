import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/repositories/base_repository.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/danmaku_api.dart';
import 'package:culcul/data/network/dio_client.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_repository.g.dart';

@riverpod
DanmakuRepository danmakuRepository(Ref ref) {
  return DanmakuRepository(
    ref.watch(danmakuApiProvider),
    ref.watch(dioClientProvider),
  );
}

class DanmakuRepository extends BaseRepository {
  final DanmakuApi _api;
  final Dio _dio;

  DanmakuRepository(this._api, this._dio);

  Future<Result<DmSegMobileReply, AppException>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) {
    return safeCall(() async {
      final response = await _api.fetchDanmakuSegment(
        oid: oid,
        pid: pid,
        segmentIndex: segmentIndex,
      );
      return DmSegMobileReply.fromBuffer(response);
    });
  }

  Future<Result<DmViewReply, AppException>> fetchDanmakuView({
    required int oid,
    required int pid,
  }) {
    return safeCall(() async {
      final response = await _api.fetchDanmakuView(
        oid: oid,
        pid: pid,
      );
      return DmViewReply.fromBuffer(response);
    });
  }

  Future<Result<List<int>, AppException>> fetchMaskData(String url) async {
    return safeCall(() async {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      return response.data ?? [];
    });
  }
}
