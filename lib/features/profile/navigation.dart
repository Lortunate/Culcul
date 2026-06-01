import 'package:culcul/features/profile/presentation/pages/profile_page.dart';
import 'package:culcul/features/profile/presentation/pages/followers_page.dart';
import 'package:culcul/features/profile/presentation/pages/followings_page.dart';
import 'package:culcul/features/profile/presentation/pages/user_profile_page.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:flutter/widgets.dart';

typedef ProfileDynamicNavigationWrapper = Widget Function({required Widget child});

class ProfileRouteNavigation {
  const ProfileRouteNavigation({
    required this.onLogin,
    required this.onOpenSettings,
    required this.onOpenHistory,
    required this.onOpenFavorites,
    required this.onOpenToView,
    required this.onOpenFollowings,
    required this.onOpenFollowers,
    required this.onOpenUser,
    required this.onOpenVideo,
    required this.wrapDynamicNavigation,
    required this.onOpenChat,
  });

  final VoidCallback onLogin;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenHistory;
  final VoidCallback onOpenFavorites;
  final VoidCallback onOpenToView;
  final ValueChanged<int> onOpenFollowings;
  final ValueChanged<int> onOpenFollowers;
  final ValueChanged<int> onOpenUser;
  final ValueChanged<String> onOpenVideo;
  final ProfileDynamicNavigationWrapper wrapDynamicNavigation;
  final OpenProfileChat onOpenChat;
}

Widget buildProfileRoutePage({required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(navigation: navigation, child: const ProfilePage());
}

Widget buildFollowingsRoutePage(int vmid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: FollowingsPage(vmid: vmid),
  );
}

Widget buildFollowersRoutePage(int vmid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: FollowersPage(vmid: vmid),
  );
}

Widget buildUserProfileRoutePage(int mid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: UserProfilePage(mid: mid),
  );
}

Widget _buildProfileNavigationScope({
  required ProfileRouteNavigation navigation,
  required Widget child,
}) {
  return ProfileNavigationScope(
    onLogin: navigation.onLogin,
    onOpenSettings: navigation.onOpenSettings,
    onOpenHistory: navigation.onOpenHistory,
    onOpenFavorites: navigation.onOpenFavorites,
    onOpenToView: navigation.onOpenToView,
    onOpenFollowings: navigation.onOpenFollowings,
    onOpenFollowers: navigation.onOpenFollowers,
    onOpenUser: navigation.onOpenUser,
    onOpenVideo: navigation.onOpenVideo,
    onOpenChat: navigation.onOpenChat,
    child: navigation.wrapDynamicNavigation(child: child),
  );
}
