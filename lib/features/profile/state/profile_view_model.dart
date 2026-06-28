import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/models/profile_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.g.dart';

@riverpod
Future<ProfileUser> myProfile(Ref ref) async {
  final session = ref.watch(currentUserProvider);
  if (session == null || !session.isLoggedIn) {
    return const ProfileUser(
      id: '0',
      username: '',
      followersCount: 0,
      followingCount: 0,
      videosCount: 0,
      isFollowing: false,
      isVerified: false,
    );
  }
  final result = await ref
      .watch(profileRepositoryProvider)
      .getProfile(int.parse(session.uid));
  return result.when(success: (data) => data, failure: (error) => throw error);
}
