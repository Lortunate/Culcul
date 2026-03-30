import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/protos/dm.pb.dart';
import 'package:culcul/features/video/application/use_case/video_extra_use_cases.dart';

part 'danmaku_view_model.g.dart';

@riverpod
class DanmakuProvider extends _$DanmakuProvider {
  @override
  FutureOr<void> build() {}

  Future<List<DanmakuElem>> loadSegment({
    required int oid,
    required int pid,
    required int segmentIndex,
  }) async {
    final result = await ref
        .read(videoExtraUseCasesProvider)
        .loadDanmakuSegment(
          DanmakuSegmentQuery(oid: oid, pid: pid, segmentIndex: segmentIndex),
        );
    return result.when(
      success: (value) => value.elems,
      failure: (error) => throw Exception(error.message),
    );
  }
}
