import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/protos/dm.pb.dart';

abstract class DanmakuRepository {
  Future<Result<DmSegMobileReply, AppError>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  });

  Future<Result<DmViewReply, AppError>> fetchDanmakuView({
    required int oid,
    required int pid,
  });

  Future<Result<List<int>, AppError>> fetchMaskData(String url);
}
