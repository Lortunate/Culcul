import 'package:culcul/features/profile/application/profile_view_contracts.dart';

typedef CachedProfileReader = Future<ProfileUser?> Function(String userId);
typedef FreshProfileLoader = Future<ProfileUser> Function(String userId);

class ProfileLoadActionResult {
  const ProfileLoadActionResult({
    required this.profile,
    required this.shouldRefreshInBackground,
  });

  final ProfileUser profile;
  final bool shouldRefreshInBackground;
}

Future<ProfileLoadActionResult> loadUserProfileAction({
  required String userId,
  required CachedProfileReader readCachedProfile,
  required FreshProfileLoader loadFreshProfile,
}) async {
  final cachedProfile = await readCachedProfile(userId);
  if (cachedProfile != null) {
    return ProfileLoadActionResult(
      profile: cachedProfile,
      shouldRefreshInBackground: true,
    );
  }

  final freshProfile = await loadFreshProfile(userId);
  return ProfileLoadActionResult(profile: freshProfile, shouldRefreshInBackground: false);
}
