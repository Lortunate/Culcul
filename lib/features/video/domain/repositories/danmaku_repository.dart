import 'package:culcul/protos/dm.pb.dart';

abstract class DanmakuRepository {
  Future<DmSegMobileReply> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  });

  Future<DmViewReply> fetchDanmakuView({required int oid, required int pid});

  Future<List<int>> fetchMaskData(String url);
}
