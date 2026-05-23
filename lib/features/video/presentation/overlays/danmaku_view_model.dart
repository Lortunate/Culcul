import 'dart:async';

import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/danmaku_application_providers.dart';
import 'package:culcul/features/video/application/models/danmaku.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_view_model.g.dart';

@riverpod
class DanmakuProvider extends _$DanmakuProvider {
  @override
  FutureOr<void> build() {}

  Future<Result<List<DanmakuEntry>, AppError>> loadSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) async {
    final result = await ref
        .read(danmakuPortProvider)
        .fetchDanmakuSegment(oid: oid, pid: pid, segmentIndex: segmentIndex);
    return result.map((value) => value.entries);
  }
}
