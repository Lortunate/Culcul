import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/entities/relation_user.dart';
import 'package:culcul/features/profile/domain/repositories/profile_cache_repository.dart'
    as domain;
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart'
    as domain;
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart'
    as domain;
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_query_workflows.g.dart';

@riverpod
ProfileQueryWorkflows profileQueryWorkflows(Ref ref) {
  return ProfileQueryWorkflows(
    profileCacheRepository: ref.read(profileCacheRepositoryProvider.notifier),
    profileRepository: ref.read(profileRepositoryProvider),
    relationRepository: ref.read(relationRepositoryProvider),
  );
}

class ProfileQueryWorkflows {
  final domain.ProfileCacheRepository profileCacheRepository;
  final domain.ProfileRepository profileRepository;
  final domain.RelationRepository relationRepository;

  const ProfileQueryWorkflows({
    required this.profileCacheRepository,
    required this.profileRepository,
    required this.relationRepository,
  });

  Future<Result<ProfileUser, AppError>> getProfile(String mid) async {
    return runResult(() => profileRepository.getProfile(int.parse(mid)));
  }

  Future<Result<ProfileUser?, AppError>> getCachedProfile(String mid) async {
    return runResult(() => profileCacheRepository.readProfile(mid));
  }

  Future<Result<ProfileUser, AppError>> refreshProfile(String mid) async {
    try {
      final profile = await profileRepository.getProfile(int.parse(mid));
      await profileCacheRepository.writeProfile(profile);
      return Success(profile);
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileVideo>, AppError>> getSpaceVideos({
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

  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    return runResult(() => profileRepository.getStickyVideo(vmid));
  }

  Future<Result<List<ProfileVideo>, AppError>> getMasterpieces(int vmid) async {
    return runResult(() => profileRepository.getMasterpiece(vmid));
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings({
    required int vmid,
    required int page,
  }) async {
    return runResult(() => relationRepository.getFollowings(vmid, page: page));
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers({
    required int vmid,
    required int page,
  }) async {
    return runResult(() => relationRepository.getFollowers(vmid, page: page));
  }
}
