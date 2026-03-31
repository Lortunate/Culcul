import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@riverpod
Future<ProfileUser> myProfile(Ref ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isLoggedIn || authState.user == null) {
    throw AppError.auth('Not logged in');
  }
  return ref.watch(profileRepositoryProvider).getProfile(int.parse(authState.user!.id));
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
    final profile = await ref
        .read(profileRepositoryProvider)
        .getProfile(int.parse(userId));
    await ref.read(profileCacheRepositoryProvider.notifier).writeProfile(profile);
    return profile;
  }
}
