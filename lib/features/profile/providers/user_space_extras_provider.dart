import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';

part 'user_space_extras_provider.g.dart';

@Riverpod(keepAlive: true)
Future<UserSpaceVideoModel?> userStickyVideo(Ref ref, int vmid) async {
  final repository = ref.read(profileRepositoryProvider);
  return repository.getStickyVideo(vmid);
}

@Riverpod(keepAlive: true)
Future<List<UserSpaceVideoModel>> userMasterpieces(Ref ref, int vmid) async {
  final repository = ref.read(profileRepositoryProvider);
  return repository.getMasterpiece(vmid);
}
