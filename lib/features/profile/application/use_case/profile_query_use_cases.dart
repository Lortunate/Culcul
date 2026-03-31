import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
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

part 'profile_query_use_cases.g.dart';

@riverpod
ProfileQueryUseCases profileQueryUseCases(Ref ref) {
  return ProfileQueryUseCases(
    profileCacheRepository: ref.read(profileCacheRepositoryProvider.notifier),
    profileRepository: ref.read(profileRepositoryProvider),
    relationRepository: ref.read(relationRepositoryProvider),
  );
}

class ProfileQueryUseCases {
  final domain.ProfileCacheRepository profileCacheRepository;
  final domain.ProfileRepository profileRepository;
  final domain.RelationRepository relationRepository;

  const ProfileQueryUseCases({
    required this.profileCacheRepository,
    required this.profileRepository,
    required this.relationRepository,
  });

  Future<Result<ProfileUser, AppError>> getProfile(String mid) async {
    try {
      return Success(await profileRepository.getProfile(int.parse(mid)));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ProfileUser?, AppError>> getCachedProfile(String mid) async {
    try {
      return Success(await profileCacheRepository.readProfile(mid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
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
    try {
      return Success(await profileRepository.getStickyVideo(vmid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileVideo>, AppError>> getMasterpieces(int vmid) async {
    try {
      return Success(await profileRepository.getMasterpiece(vmid));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings({
    required int vmid,
    required int page,
  }) async {
    try {
      return Success(await relationRepository.getFollowings(vmid, page: page));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers({
    required int vmid,
    required int page,
  }) async {
    try {
      return Success(await relationRepository.getFollowers(vmid, page: page));
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
