import 'package:culcul/data/api/danmaku_api.dart';

class DanmakuRepository {
  final DanmakuApi _api;

  DanmakuRepository(this._api);

  Future<List<int>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) {
    return _api.fetchDanmakuSegment(
      oid: oid,
      pid: pid,
      segmentIndex: segmentIndex,
    );
  }
}
