import 'package:culcul/features/profile/application/use_case/profile_query_use_cases.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_view_model.g.dart';

@Riverpod(keepAlive: true)
Future<ProfileVideo?> userStickyVideo(Ref ref, int vmid) async {
  final result = await ref.read(profileQueryUseCasesProvider).getStickyVideo(vmid);
  return result.when(success: (value) => value, failure: (error) => throw error);
}

@Riverpod(keepAlive: true)
Future<List<ProfileVideo>> userMasterpieces(Ref ref, int vmid) async {
  final result = await ref.read(profileQueryUseCasesProvider).getMasterpieces(vmid);
  return result.when(success: (value) => value, failure: (error) => throw error);
}
