import 'dart:async';

import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/application/profile_actions.dart';
import 'package:culcul/features/profile/application/profile_read_application_providers.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/data/profile_cache_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@riverpod
Future<ProfileUser> myProfile(Ref ref) async {
  final session = ref.watch(currentUserProvider);
  if (session == null || !session.isLoggedIn) {
    return _emptyProfileUser();
  }
  final result = await ref
      .watch(profileReadPortProvider)
      .getProfile(int.parse(session.uid));
  return result.when(success: (data) => data, failure: (error) => throw error);
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<ProfileUser> build(String userId) async {
    final result = await loadUserProfileAction(
      userId: userId,
      readCachedProfile: ref.read(profileCacheRepositoryProvider).readProfile,
      loadFreshProfile: _loadFreshProfile,
    );
    if (result.shouldRefreshInBackground) {
      unawaited(_refreshInBackground(userId));
    }
    return result.profile;
  }

  Future<void> _refreshInBackground(String userId) async {
    try {
      await Future.delayed(Duration.zero);
      final user = await _loadFreshProfile(userId);
      state = AsyncData(user);
    } catch (e) {
      // Ignore errors in background refresh
    }
  }

  Future<ProfileUser> _loadFreshProfile(String userId) async {
    final result = await ref.read(profileReadPortProvider).getProfile(int.parse(userId));
    return result.when(
      success: (data) async {
        await ref.read(profileCacheRepositoryProvider).writeProfile(data);
        return data;
      },
      failure: (error) => throw error,
    );
  }
}

ProfileUser _emptyProfileUser({String id = '0'}) {
  return ProfileUser(
    id: id,
    username: '',
    followersCount: 0,
    followingCount: 0,
    videosCount: 0,
    isFollowing: false,
    isVerified: false,
  );
}
