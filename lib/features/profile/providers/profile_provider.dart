import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/result.dart';
import 'package:culcul/data/user_info_cache_service.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/features/auth/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
Future<UserProfile> myProfile(Ref ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) {
    throw Exception('Not logged in');
  }
  final repo = ref.watch(profileRepositoryProvider);
  final result = await repo.getProfile(int.parse(authState.user!.id));
  return switch (result) {
    Success(value: final data) => data,
    Failure(exception: final e) => throw e,
  };
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<UserProfile> build(String userId) async {
    // 1. Try cache
    final cacheService = await ref.watch(userInfoCacheServiceProvider.future);
    final cachedUser = cacheService.getUser(userId);

    if (cachedUser != null) {
      // Trigger background refresh
      _refreshInBackground(userId);
      return cachedUser;
    }

    // 2. No cache, fetch from network
    return _fetchAndSave(userId);
  }

  Future<void> _refreshInBackground(String userId) async {
    try {
      // Wait a bit to ensure UI has rendered cached data
      await Future.delayed(Duration.zero);
      final user = await _fetchAndSave(userId);
      // Update state with fresh data
      state = AsyncData(user);
    } catch (e) {
      // Ignore errors in background refresh
    }
  }

  Future<UserProfile> _fetchAndSave(String userId) async {
    final repo = ref.read(profileRepositoryProvider);
    final result = await repo.getProfile(int.parse(userId));

    return switch (result) {
      Success(value: final user) => () async {
        final cacheService = await ref.read(userInfoCacheServiceProvider.future);
        await cacheService.saveUser(user);
        return user;
      }(),
      Failure(exception: final e) => throw e,
    };
  }
}
