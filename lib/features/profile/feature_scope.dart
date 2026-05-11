import 'package:culcul/features/profile/application/profile_facade.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

export 'package:culcul/features/profile/application/profile_facade.dart' show profileFacadeProvider;
export 'package:culcul/features/profile/application/profile_repository_provider.dart'
    show profileRepositoryProvider, relationRepositoryProvider;
export 'package:culcul/features/profile/application/profile_cache_repository_provider.dart'
    show profileCacheRepositoryProvider;

final profileFacadeEntryProvider = Provider<ProfileFacade>(
  (ref) => ref.watch(profileFacadeProvider),
);
