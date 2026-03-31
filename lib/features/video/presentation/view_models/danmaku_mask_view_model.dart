import 'package:culcul/features/video/application/video_extra_workflows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_mask_view_model.g.dart';

@riverpod
Future<DanmakuMasks?> danmakuMask(Ref ref, {required int oid, required int pid}) async {
  final result = await ref
      .read(videoExtraWorkflowsProvider)
      .loadDanmakuMask(oid: oid, pid: pid);
  return result.when(success: (value) => value, failure: (error) => throw error);
}
