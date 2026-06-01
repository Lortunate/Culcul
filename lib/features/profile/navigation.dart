import 'package:culcul/features/profile/presentation/pages/profile_page.dart';
import 'package:culcul/features/profile/presentation/pages/user_profile_page.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/features/profile/presentation/widgets/relation_user_list.dart';
import 'package:culcul/features/profile/state/relation_view_model.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
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
    child: _RelationUsersRoutePage(vmid: vmid, kind: _RelationUsersRouteKind.followings),
  );
}

Widget buildFollowersRoutePage(int vmid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: _RelationUsersRoutePage(vmid: vmid, kind: _RelationUsersRouteKind.followers),
  );
}

Widget buildUserProfileRoutePage(int mid, {required ProfileRouteNavigation navigation}) {
  return _buildProfileNavigationScope(
    navigation: navigation,
    child: UserProfilePage(mid: mid),
  );
}

enum _RelationUsersRouteKind { followings, followers }

class _RelationUsersRoutePage extends ConsumerWidget {
  final int vmid;
  final _RelationUsersRouteKind kind;

  const _RelationUsersRoutePage({required this.vmid, required this.kind});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return switch (kind) {
      _RelationUsersRouteKind.followings => _buildScaffold(
        context: context,
        title: t.profile.followings.title,
        asyncValue: ref.watch(followingsProvider(vmid)),
        onRefresh: () => ref.read(followingsProvider(vmid).notifier).refresh(),
        onLoadMore: () => ref.read(followingsProvider(vmid).notifier).loadMore(),
        hasMore: ref.watch(followingsProvider(vmid).notifier).hasMore,
        emptyText: t.profile.followings.empty,
        colorScheme: colorScheme,
      ),
      _RelationUsersRouteKind.followers => _buildScaffold(
        context: context,
        title: t.profile.followers.title,
        asyncValue: ref.watch(followersProvider(vmid)),
        onRefresh: () => ref.read(followersProvider(vmid).notifier).refresh(),
        onLoadMore: () => ref.read(followersProvider(vmid).notifier).loadMore(),
        hasMore: ref.watch(followersProvider(vmid).notifier).hasMore,
        emptyText: t.profile.followers.empty,
        colorScheme: colorScheme,
      ),
    };
  }

  Widget _buildScaffold({
    required BuildContext context,
    required String title,
    required AsyncValue<List<ProfileRelationUser>> asyncValue,
    required Future<void> Function() onRefresh,
    required Future<void> Function() onLoadMore,
    required bool hasMore,
    required String emptyText,
    required ColorScheme colorScheme,
  }) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: RelationUserList(
        asyncValue: asyncValue,
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        hasMore: hasMore,
        emptyText: emptyText,
      ),
    );
  }
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
