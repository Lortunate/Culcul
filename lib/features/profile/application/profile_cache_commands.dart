import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ClearProfileCache = Future<void> Function();

final clearProfileCacheProvider = Provider<ClearProfileCache>((ref) {
  return () => ref.read(profileCacheRepositoryProvider).clearAll();
});
