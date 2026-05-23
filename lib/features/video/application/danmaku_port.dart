import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/models/danmaku.dart';

/// Video danmaku application boundary.
abstract interface class DanmakuPort {
  Future<Result<DanmakuSegment, AppError>> fetchDanmakuSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  });
}
