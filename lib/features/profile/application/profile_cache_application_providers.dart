import 'package:culcul/features/profile/application/profile_cache_port.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_cache_application_providers.g.dart';

@riverpod
ProfileCachePort profileCachePort(Ref ref) {
  return ref.watch(profileCacheRepositoryProvider);
}
