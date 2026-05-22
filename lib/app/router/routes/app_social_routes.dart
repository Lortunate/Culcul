part of '../app_routes.dart';

@TypedGoRoute<FollowingsRoute>(path: '/followings/:vmid')
class FollowingsRoute extends AppRouteData with $FollowingsRoute {
  final int vmid;

  const FollowingsRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildFollowingsRoutePage(
      vmid,
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

@TypedGoRoute<FollowersRoute>(path: '/followers/:vmid')
class FollowersRoute extends AppRouteData with $FollowersRoute {
  final int vmid;

  const FollowersRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildFollowersRoutePage(
      vmid,
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

@TypedGoRoute<UserProfileRoute>(path: '/user/:mid')
class UserProfileRoute extends AppRouteData with $UserProfileRoute {
  final int mid;

  const UserProfileRoute({required this.mid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildUserProfileRoutePage(
      mid,
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

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends AppRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildLoginRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  routes: [TypedGoRoute<AboutRoute>(path: 'about')],
)
class SettingsRoute extends AppRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildSettingsRoutePage(onOpenAbout: () => const AboutRoute().push(context));
  }
}

class AboutRoute extends AppRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildAboutRoutePage();
}

@TypedGoRoute<ToViewRoute>(path: '/to-view')
class ToViewRoute extends AppRouteData with $ToViewRoute {
  const ToViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildToViewRoutePage(
      onLogin: () => const LoginRoute().push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends AppRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildHistoryRoutePage(
      onLogin: () => const LoginRoute().push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}
