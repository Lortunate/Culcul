import 'package:culcul/features/profile/presentation/pages/profile_page.dart';
import 'package:culcul/features/profile/presentation/pages/user_profile_page.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/features/profile/presentation/widgets/relation_user_list.dart';
import 'package:culcul/features/profile/state/relation_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  final Widget Function({required Widget child}) wrapDynamicNavigation;
  final void Function({required int talkerId, required String name, String? avatarUrl})
  onOpenChat;
}

Widget buildProfileRoutePage({required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(navigation: navigation, child: const ProfilePage());
}

Widget buildFollowingsRoutePage(int vmid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: Consumer(
      builder: (context, ref, _) {
        final t = Translations.of(context);
        final colorScheme = Theme.of(context).colorScheme;
        final provider = followingsProvider(vmid);

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(title: Text(t.profile.followings.title), centerTitle: true),
          body: RelationUserList(
            asyncValue: ref.watch(provider),
            onRefresh: () => ref.read(provider.notifier).refresh(),
            onLoadMore: () => ref.read(provider.notifier).loadMore(),
            hasMore: ref.watch(provider.notifier).hasMore,
            emptyText: t.profile.followings.empty,
          ),
        );
      },
    ),
  );
}

Widget buildFollowersRoutePage(int vmid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: Consumer(
      builder: (context, ref, _) {
        final t = Translations.of(context);
        final colorScheme = Theme.of(context).colorScheme;
        final provider = followersProvider(vmid);

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(title: Text(t.profile.followers.title), centerTitle: true),
          body: RelationUserList(
            asyncValue: ref.watch(provider),
            onRefresh: () => ref.read(provider.notifier).refresh(),
            onLoadMore: () => ref.read(provider.notifier).loadMore(),
            hasMore: ref.watch(provider.notifier).hasMore,
            emptyText: t.profile.followers.empty,
          ),
        );
      },
    ),
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
