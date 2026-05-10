import 'package:culcul/features/profile/domain/repositories/profile_repository.dart';
import 'package:culcul/features/profile/domain/repositories/relation_repository.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/data/relation_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_facade.g.dart';

@riverpod
ProfileFacade profileFacade(Ref ref) {
  return ProfileFacade(
    ref.watch(profileRepositoryProvider),
    ref.watch(relationRepositoryProvider),
  );
}

class ProfileFacade {
  ProfileFacade(this.profileRepository, this.relationRepository);

  final ProfileRepository profileRepository;
  final RelationRepository relationRepository;
}
