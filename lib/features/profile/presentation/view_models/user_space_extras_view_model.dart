import 'package:culcul/features/profile/application/profile_query_workflows.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_view_model.g.dart';

@Riverpod(keepAlive: true)
Future<ProfileVideo?> userStickyVideo(Ref ref, int vmid) async {
  final result = await ref.read(profileQueryWorkflowsProvider).getStickyVideo(vmid);
  return result.when(success: (value) => value, failure: (error) => throw error);
}

@Riverpod(keepAlive: true)
Future<List<ProfileVideo>> userMasterpieces(Ref ref, int vmid) async {
  final result = await ref.read(profileQueryWorkflowsProvider).getMasterpieces(vmid);
  return result.when(success: (value) => value, failure: (error) => throw error);
}
