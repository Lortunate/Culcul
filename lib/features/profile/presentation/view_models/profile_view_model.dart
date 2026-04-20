import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/feature_scope.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@riverpod
Future<ProfileUser> myProfile(Ref ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) {
    return _emptyProfileUser();
  }
  final result = await ref
      .watch(profileRepositoryProvider)
      .getProfile(int.parse(authState.user!.id));
  return result.dataOrNull ?? _emptyProfileUser(id: authState.user!.id);
}

@riverpod
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  Future<ProfileUser> build(String userId) async {
    final cachedUser = await ref
        .read(profileCacheRepositoryProvider.notifier)
        .readProfile(userId);

    if (cachedUser != null) {
      _refreshInBackground(userId);
      return cachedUser;
    }

    return _loadFresh(userId);
  }

  Future<void> _refreshInBackground(String userId) async {
    try {
      await Future.delayed(Duration.zero);
      final user = await _loadFresh(userId);
      state = AsyncData(user);
    } catch (e) {
      // Ignore errors in background refresh
    }
  }

  Future<ProfileUser> _loadFresh(String userId) async {
    final result = await ref
        .read(profileRepositoryProvider)
        .getProfile(int.parse(userId));
    final profile = result.dataOrNull ?? _emptyProfileUser(id: userId);
    await ref.read(profileCacheRepositoryProvider.notifier).writeProfile(profile);
    return profile;
  }
}

ProfileUser _emptyProfileUser({String id = '0'}) {
  return ProfileUser(
    id: id,
    username: '',
    avatarUrl: null,
    bannerUrl: null,
    bio: null,
    location: null,
    followersCount: 0,
    followingCount: 0,
    videosCount: 0,
    dynamicCount: 0,
    likesCount: 0,
    level: 0,
    vipType: 0,
    vipStatus: 0,
    coins: null,
    bCoins: null,
    currentExp: null,
    nextExp: null,
    currentMinExp: null,
    isFollowing: false,
    isVerified: false,
    createdAt: null,
  );
}
