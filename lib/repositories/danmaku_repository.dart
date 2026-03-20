import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/repositories/base_repository.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/api/danmaku_api.dart';
import 'package:culcul/data/api/resource_api.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_repository.g.dart';

@riverpod
DanmakuRepository danmakuRepository(Ref ref) {
  return DanmakuRepository(
    ref.watch(danmakuApiProvider),
    ref.watch(resourceApiProvider),
  );
}

class DanmakuRepository extends BaseRepository {
  final DanmakuApi _api;
  final ResourceApi _resourceApi;

  DanmakuRepository(this._api, this._resourceApi);

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
      return _resourceApi.fetchBytes(url);
    });
  }
}
