import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_view_model.g.dart';

@Riverpod(keepAlive: true)
Future<ProfileVideo?> userStickyVideo(Ref ref, int vmid) async {
  final result = await ref.read(profileRepositoryProvider).getStickyVideo(vmid);
  return result.dataOrNull;
}

@Riverpod(keepAlive: true)
Future<List<ProfileVideo>> userMasterpieces(Ref ref, int vmid) async {
  final result = await ref.read(profileRepositoryProvider).getMasterpiece(vmid);
  return result.dataOrNull ?? const <ProfileVideo>[];
}
