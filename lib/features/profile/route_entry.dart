import 'package:culcul/features/profile/presentation/pages/profile_page.dart';
import 'package:culcul/features/profile/presentation/pages/followers_page.dart';
import 'package:culcul/features/profile/presentation/pages/followings_page.dart';
import 'package:culcul/features/profile/presentation/pages/user_profile_page.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:flutter/widgets.dart';

typedef ProfileDynamicNavigationWrapper = Widget Function({required Widget child});

Widget buildProfileRoutePage({
  required VoidCallback onLogin,
  required VoidCallback onOpenSettings,
  required VoidCallback onOpenHistory,
  required VoidCallback onOpenFavorites,
  required VoidCallback onOpenToView,
  required ValueChanged<int> onOpenFollowings,
  required ValueChanged<int> onOpenFollowers,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ProfileDynamicNavigationWrapper wrapDynamicNavigation,
  required OpenProfileChat onOpenChat,
}) {
  return _buildProfileNavigationScope(
    onLogin: onLogin,
    onOpenSettings: onOpenSettings,
    onOpenHistory: onOpenHistory,
    onOpenFavorites: onOpenFavorites,
    onOpenToView: onOpenToView,
    onOpenFollowings: onOpenFollowings,
    onOpenFollowers: onOpenFollowers,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    wrapDynamicNavigation: wrapDynamicNavigation,
    onOpenChat: onOpenChat,
    child: const ProfilePage(),
  );
}

Widget buildFollowingsRoutePage(
  int vmid, {
  required VoidCallback onLogin,
  required VoidCallback onOpenSettings,
  required VoidCallback onOpenHistory,
  required VoidCallback onOpenFavorites,
  required VoidCallback onOpenToView,
  required ValueChanged<int> onOpenFollowings,
  required ValueChanged<int> onOpenFollowers,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ProfileDynamicNavigationWrapper wrapDynamicNavigation,
  required OpenProfileChat onOpenChat,
}) {
  return _buildProfileNavigationScope(
    onLogin: onLogin,
    onOpenSettings: onOpenSettings,
    onOpenHistory: onOpenHistory,
    onOpenFavorites: onOpenFavorites,
    onOpenToView: onOpenToView,
    onOpenFollowings: onOpenFollowings,
    onOpenFollowers: onOpenFollowers,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    wrapDynamicNavigation: wrapDynamicNavigation,
    onOpenChat: onOpenChat,
    child: FollowingsPage(vmid: vmid),
  );
}

Widget buildFollowersRoutePage(
  int vmid, {
  required VoidCallback onLogin,
  required VoidCallback onOpenSettings,
  required VoidCallback onOpenHistory,
  required VoidCallback onOpenFavorites,
  required VoidCallback onOpenToView,
  required ValueChanged<int> onOpenFollowings,
  required ValueChanged<int> onOpenFollowers,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ProfileDynamicNavigationWrapper wrapDynamicNavigation,
  required OpenProfileChat onOpenChat,
}) {
  return _buildProfileNavigationScope(
    onLogin: onLogin,
    onOpenSettings: onOpenSettings,
    onOpenHistory: onOpenHistory,
    onOpenFavorites: onOpenFavorites,
    onOpenToView: onOpenToView,
    onOpenFollowings: onOpenFollowings,
    onOpenFollowers: onOpenFollowers,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    wrapDynamicNavigation: wrapDynamicNavigation,
    onOpenChat: onOpenChat,
    child: FollowersPage(vmid: vmid),
  );
}

Widget buildUserProfileRoutePage(
  int mid, {
  required VoidCallback onLogin,
  required VoidCallback onOpenSettings,
  required VoidCallback onOpenHistory,
  required VoidCallback onOpenFavorites,
  required VoidCallback onOpenToView,
  required ValueChanged<int> onOpenFollowings,
  required ValueChanged<int> onOpenFollowers,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ProfileDynamicNavigationWrapper wrapDynamicNavigation,
  required OpenProfileChat onOpenChat,
}) {
  return _buildProfileNavigationScope(
    onLogin: onLogin,
    onOpenSettings: onOpenSettings,
    onOpenHistory: onOpenHistory,
    onOpenFavorites: onOpenFavorites,
    onOpenToView: onOpenToView,
    onOpenFollowings: onOpenFollowings,
    onOpenFollowers: onOpenFollowers,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    wrapDynamicNavigation: wrapDynamicNavigation,
    onOpenChat: onOpenChat,
    child: UserProfilePage(mid: mid),
  );
}

Widget _buildProfileNavigationScope({
  required VoidCallback onLogin,
  required VoidCallback onOpenSettings,
  required VoidCallback onOpenHistory,
  required VoidCallback onOpenFavorites,
  required VoidCallback onOpenToView,
  required ValueChanged<int> onOpenFollowings,
  required ValueChanged<int> onOpenFollowers,
  required ValueChanged<int> onOpenUser,
  required ValueChanged<String> onOpenVideo,
  required ProfileDynamicNavigationWrapper wrapDynamicNavigation,
  required OpenProfileChat onOpenChat,
  required Widget child,
}) {
  return ProfileNavigationScope(
    onLogin: onLogin,
    onOpenSettings: onOpenSettings,
    onOpenHistory: onOpenHistory,
    onOpenFavorites: onOpenFavorites,
    onOpenToView: onOpenToView,
    onOpenFollowings: onOpenFollowings,
    onOpenFollowers: onOpenFollowers,
    onOpenUser: onOpenUser,
    onOpenVideo: onOpenVideo,
    onOpenChat: onOpenChat,
    child: wrapDynamicNavigation(child: child),
  );
}
