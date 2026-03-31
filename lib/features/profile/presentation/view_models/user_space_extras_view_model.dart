import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_view_model.g.dart';

@Riverpod(keepAlive: true)
Future<ProfileVideo?> userStickyVideo(Ref ref, int vmid) async {
  return ref.read(profileRepositoryProvider).getStickyVideo(vmid);
}

@Riverpod(keepAlive: true)
Future<List<ProfileVideo>> userMasterpieces(Ref ref, int vmid) async {
  return ref.read(profileRepositoryProvider).getMasterpiece(vmid);
}
