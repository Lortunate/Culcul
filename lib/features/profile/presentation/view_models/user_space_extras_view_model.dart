import 'package:culcul/features/profile/application/profile_view_contracts.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_view_model.g.dart';

@Riverpod(keepAlive: true)
Future<ProfileVideo?> userStickyVideo(Ref ref, int vmid) async {
  final result = await ref.read(profileRepositoryProvider).getStickyVideo(vmid);
  return result.dataOrNull?.toProfileVideo();
}

@Riverpod(keepAlive: true)
Future<List<ProfileVideo>> userMasterpieces(Ref ref, int vmid) async {
  final result = await ref.read(profileRepositoryProvider).getMasterpiece(vmid);
  return result.when(
    success: (data) => data.toProfileVideos(),
    failure: (error) => throw error,
  );
}
