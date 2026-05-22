part of '../app_routes.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/home')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<DynamicRoute>(path: '/dynamic')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<RankingRoute>(path: '/ranking')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<ProfileRoute>(path: '/profile')]),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainShell(navigationShell: navigationShell);
  }
}

class HomeRoute extends AppRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildHomePage(
      onOpenSearch: () => const SearchRoute().push(context),
      onOpenProfile: () => const ProfileRoute().go(context),
      onOpenNotification: () => const NotificationRoute().push(context),
      onOpenLiveRoom: (roomId) => LiveRoomRoute(roomId: roomId).push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}

class DynamicRoute extends AppRouteData with $DynamicRoute {
  const DynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildDynamicRoutePage(
      onLogin: () => const LoginRoute().push(context),
      onOpenSearch: () => const SearchRoute().push(context),
      onOpenPublish: () => const PublishDynamicRoute().push(context),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
      onOpenLiveRoom: (roomId) => LiveRoomRoute(roomId: roomId).push(context),
      onOpenDynamicDetail: (id) => DynamicDetailRoute(id: id).push(context),
      onOpenArticle: (url, title) => _pushArticleDetail(context, url: url, title: title),
      onOpenTopic: (topicId, topicName) =>
          _pushTopicDetail(context, topicId: topicId, topicName: topicName),
    );
  }
}

class RankingRoute extends AppRouteData with $RankingRoute {
  const RankingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildRankingRoutePage(
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}

class ProfileRoute extends AppRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildProfileRoutePage(
      onLogin: () => const LoginRoute().push(context),
      onOpenSettings: () => const SettingsRoute().push(context),
      onOpenHistory: () => const HistoryRoute().push(context),
      onOpenFavorites: () => const FavoritesRoute().push(context),
      onOpenToView: () => const ToViewRoute().push(context),
      onOpenFollowings: (vmid) => FollowingsRoute(vmid: vmid).push(context),
      onOpenFollowers: (vmid) => FollowersRoute(vmid: vmid).push(context),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
      onOpenLiveRoom: (roomId) => LiveRoomRoute(roomId: roomId).push(context),
      onOpenDynamicDetail: (id) => DynamicDetailRoute(id: id).push(context),
      onOpenArticle: (url, title) => _pushArticleDetail(context, url: url, title: title),
      onOpenTopic: (topicId, topicName) =>
          _pushTopicDetail(context, topicId: topicId, topicName: topicName),
      onOpenChat: ({required talkerId, required name, avatarUrl}) {
        ChatRoute(
          talkerId: talkerId,
          $extra: ChatRouteInput(name: name, avatarUrl: avatarUrl),
        ).push(context);
      },
    );
  }
}
