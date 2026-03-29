import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/danmaku_api.dart';
import 'package:culcul/data/api/resource_api.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_repository.g.dart';

@riverpod
DanmakuRepository danmakuRepository(Ref ref) {
  return DanmakuRepository(ref.watch(danmakuApiProvider), ref.watch(resourceApiProvider));
}

class DanmakuRepository extends BaseRepository {
  final DanmakuApi _api;
  final ResourceApi _resourceApi;

  DanmakuRepository(this._api, this._resourceApi);

  Future<DmSegMobileReply> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) {
    return request(() async {
      final response = await _api.fetchDanmakuSegment(
        oid: oid,
        pid: pid,
        segmentIndex: segmentIndex,
      );
      return DmSegMobileReply.fromBuffer(response);
    });
  }

  Future<DmViewReply> fetchDanmakuView({
    required int oid,
    required int pid,
  }) {
    return request(() async {
      final response = await _api.fetchDanmakuView(oid: oid, pid: pid);
      return DmViewReply.fromBuffer(response);
    });
  }

  Future<List<int>> fetchMaskData(String url) async {
    return request(() async {
      return _resourceApi.fetchBytes(url);
    });
  }
}

