import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_query_use_cases.g.dart';

@riverpod
ProfileQueryUseCases profileQueryUseCases(Ref ref) {
  return ProfileQueryUseCases(
    profileRepository: ref.read(profileRepositoryProvider),
    relationRepository: ref.read(relationRepositoryProvider),
  );
}

class ProfileQueryUseCases {
  final ProfileRepository profileRepository;
  final RelationRepository relationRepository;

  const ProfileQueryUseCases({
    required this.profileRepository,
    required this.relationRepository,
  });

  Future<Result<UserProfile, AppError>> getProfile(String mid) async {
    try {
      return Success(await profileRepository.getProfile(int.parse(mid)));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<UserSpaceVideoModel>, AppError>> getSpaceVideos({
    required int mid,
    required int page,
    required String order,
  }) async {
    try {
      return Success(
        await profileRepository.getSpaceVideos(mid: mid, page: page, order: order),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<RelationUser>, AppError>> getFollowings({
    required int vmid,
    required int page,
  }) async {
    try {
      final data = await relationRepository.getFollowings(vmid, pn: page);
      return Success(data.list);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<RelationUser>, AppError>> getFollowers({
    required int vmid,
    required int page,
  }) async {
    try {
      final data = await relationRepository.getFollowers(vmid, pn: page);
      return Success(data.list);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
