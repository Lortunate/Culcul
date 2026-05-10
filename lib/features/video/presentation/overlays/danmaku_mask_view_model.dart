import 'package:culcul/features/video/application/video_extra_workflows.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_mask_view_model.g.dart';

@riverpod
Future<Result<DanmakuMasks?, AppError>> danmakuMask(
  Ref ref, {
  required int oid,
  required int pid,
}) async {
  final result = await ref
      .read(videoExtraWorkflowsProvider)
      .loadDanmakuMask(oid: oid, pid: pid);
  return result;
}
