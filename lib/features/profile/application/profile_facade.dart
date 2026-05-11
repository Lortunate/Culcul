import 'package:culcul/features/profile/domain/repositories/profile_repository.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart';
import 'package:culcul/features/profile/application/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_facade.g.dart';

@riverpod
ProfileFacade profileFacade(Ref ref) {
  return ProfileFacade(
    ref.watch(profileRepositoryEntryProvider),
    ref.watch(relationRepositoryEntryProvider),
  );
}

class ProfileFacade {
  ProfileFacade(ProfileRepository profileRepository, RelationRepository relationRepository)
    : _profileRepository = profileRepository,
      _relationRepository = relationRepository;

  // ignore: unused_field
  final ProfileRepository _profileRepository;
  // ignore: unused_field
  final RelationRepository _relationRepository;
}
