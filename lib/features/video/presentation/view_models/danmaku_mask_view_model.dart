import 'package:culcul/features/video/application/use_case/video_extra_use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_mask_view_model.g.dart';

@riverpod
Future<DanmakuMasks?> danmakuMask(Ref ref, {required int oid, required int pid}) async {
  final result = await ref
      .read(videoExtraUseCasesProvider)
      .loadDanmakuMask(DanmakuMaskQuery(oid: oid, pid: pid));
  return result.when(success: (value) => value, failure: (error) => throw error);
}
