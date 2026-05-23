import 'package:culcul/features/profile/application/user_space_extras_application_providers.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_view_model.g.dart';

@Riverpod(keepAlive: true)
Future<ProfileVideo?> userStickyVideo(Ref ref, int vmid) async {
  final result = await ref.read(userSpaceExtrasPortProvider).getStickyVideo(vmid);
  return result.dataOrNull;
}

@Riverpod(keepAlive: true)
Future<List<ProfileVideo>> userMasterpieces(Ref ref, int vmid) async {
  final result = await ref.read(userSpaceExtrasPortProvider).getMasterpiece(vmid);
  return result.when(success: (data) => data, failure: (error) => throw error);
}
