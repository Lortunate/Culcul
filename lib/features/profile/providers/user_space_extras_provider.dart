import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/types/result.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_space_extras_provider.g.dart';

@Riverpod(keepAlive: true)
Future<UserSpaceVideoModel?> userStickyVideo(Ref ref, int vmid) async {
  final repository = ref.read(profileRepositoryProvider);
  final result = await repository.getStickyVideo(vmid);
  return switch (result) {
    Success(value: final data) => data,
    Failure(exception: final e) => throw e,
  };
}

@Riverpod(keepAlive: true)
Future<List<UserSpaceVideoModel>> userMasterpieces(Ref ref, int vmid) async {
  final repository = ref.read(profileRepositoryProvider);
  final result = await repository.getMasterpiece(vmid);
  return switch (result) {
    Success(value: final list) => list,
    Failure(exception: final e) => throw e,
  };
}
