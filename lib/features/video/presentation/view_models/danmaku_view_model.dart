import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/video.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_view_model.g.dart';

@riverpod
class DanmakuProvider extends _$DanmakuProvider {
  @override
  FutureOr<void> build() {}

  Future<Result<List<DanmakuElem>, AppError>> loadSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) async {
    final result = await ref
        .read(danmakuRepositoryProvider)
        .fetchDanmakuSegment(oid: oid, pid: pid, segmentIndex: segmentIndex);
    return result.map((value) => value.elems);
  }
}
