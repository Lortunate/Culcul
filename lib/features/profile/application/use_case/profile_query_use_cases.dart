import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/data/models/relation/relation_model.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/data/models/user/user_space_video_model.dart';
import 'package:culcul/features/profile/data/mappers/profile_mapper.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';
import 'package:culcul/features/profile/data/relation_repository.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/entities/relation_user.dart';
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
  final ProfileCacheRepository profileCacheRepository;
  final ProfileRepository profileRepository;
  final RelationRepository relationRepository;

  const ProfileQueryUseCases({
    required this.profileCacheRepository,
    required this.profileRepository,
    required this.relationRepository,
  });

  Future<Result<ProfileUser, AppError>> getProfile(String mid) async {
    try {
      return Success((await profileRepository.getProfile(int.parse(mid))).toDomain());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ProfileUser?, AppError>> getCachedProfile(String mid) async {
    try {
      return Success((await profileCacheRepository.read(mid))?.toDomain());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ProfileUser, AppError>> refreshProfile(String mid) async {
    try {
      final profile = await profileRepository.getProfile(int.parse(mid));
      await profileCacheRepository.write(profile);
      return Success(profile.toDomain());
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
        (await profileRepository.getSpaceVideos(
          mid: mid,
          page: page,
          order: order,
        )).map((item) => item.toDomain()).toList(),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<ProfileVideo?, AppError>> getStickyVideo(int vmid) async {
    try {
      return Success((await profileRepository.getStickyVideo(vmid))?.toDomain());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileVideo>, AppError>> getMasterpieces(int vmid) async {
    try {
      return Success(
        (await profileRepository.getMasterpiece(
          vmid,
        )).map((item) => item.toDomain()).toList(),
      );
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowings({
    required int vmid,
    required int page,
  }) async {
    try {
      final data = await relationRepository.getFollowings(vmid, pn: page);
      return Success(data.list.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }

  Future<Result<List<ProfileRelationUser>, AppError>> getFollowers({
    required int vmid,
    required int page,
  }) async {
    try {
      final data = await relationRepository.getFollowers(vmid, pn: page);
      return Success(data.list.map((item) => item.toDomain()).toList());
    } catch (error) {
      return Failure(AppError.fromObject(error));
    }
  }
}
