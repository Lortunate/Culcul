import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/result/run_result.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/repositories/profile_cache_repository.dart'
    as domain;
import 'package:culcul/features/profile/domain/repositories/profile_repository.dart'
    as domain;
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_query_workflows.g.dart';

@riverpod
ProfileQueryWorkflows profileQueryWorkflows(Ref ref) {
  return ProfileQueryWorkflows(
    profileCacheRepository: ref.read(profileCacheRepositoryProvider.notifier),
    profileRepository: ref.read(profileRepositoryProvider),
  );
}

class ProfileQueryWorkflows {
  final domain.ProfileCacheRepository profileCacheRepository;
  final domain.ProfileRepository profileRepository;

  const ProfileQueryWorkflows({
    required this.profileCacheRepository,
    required this.profileRepository,
  });

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
}
