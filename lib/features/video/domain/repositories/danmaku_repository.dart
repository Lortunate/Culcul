import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/domain/entities/danmaku_model.dart';

abstract class DanmakuRepository {
  Future<Result<DanmakuSegment, AppError>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  });

  Future<Result<DanmakuView, AppError>> fetchDanmakuView({
    required int oid,
    required int pid,
  });

  Future<Result<List<int>, AppError>> fetchMaskData(String url);
}
