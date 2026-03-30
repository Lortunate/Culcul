import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:culcul/features/profile/data/profile_repository.dart';

part 'profile_provider.g.dart';

@riverpod
Future<UserProfile> myProfile(Ref ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) {
    throw Exception('Not logged in');
  }
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(int.parse(authState.user!.id));
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserProfile> build(String userId) async {
    final cache = ref.read(profileCacheRepositoryProvider.notifier);
    final cachedUser = await cache.read(userId);

    if (cachedUser != null) {
      _refreshInBackground(userId);
      return cachedUser;
    }

    return _fetchAndSave(userId);
  }

  Future<void> _refreshInBackground(String userId) async {
    try {
      await Future.delayed(Duration.zero);
      final user = await _fetchAndSave(userId);
      state = AsyncData(user);
    } catch (e) {
      // Ignore errors in background refresh
    }
  }

  Future<UserProfile> _fetchAndSave(String userId) async {
    final repo = ref.read(profileRepositoryProvider);
    final user = await repo.getProfile(int.parse(userId));
    await ref.read(profileCacheRepositoryProvider.notifier).write(user);
    return user;
  }
}
