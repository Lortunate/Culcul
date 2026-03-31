part of '../app_routes.dart';

@TypedGoRoute<WeeklyRoute>(path: '/weekly')
class WeeklyRoute extends GoRouteData with $WeeklyRoute {
  const WeeklyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildWeeklyRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<VideoDetailRoute>(path: '/video/:bvid')
class VideoDetailRoute extends GoRouteData with $VideoDetailRoute {
  final String bvid;

  const VideoDetailRoute({required this.bvid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildVideoDetailRoutePage(bvid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<LiveRoomRoute>(path: '/live/:roomId')
class LiveRoomRoute extends GoRouteData with $LiveRoomRoute {
  final int roomId;

  const LiveRoomRoute({required this.roomId});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildLiveRoomRoutePage(roomId);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<CommentReplyRoute>(path: '/video/:bvid/comment/:oid/:rootId')
class CommentReplyRoute extends GoRouteData with $CommentReplyRoute {
  final String bvid;
  final int oid;
  final int rootId;
  final CommentReplyRouteInput? $extra;

  const CommentReplyRoute({
    required this.bvid,
    required this.oid,
    required this.rootId,
    this.$extra,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final routeExtra = $extra;
    if (routeExtra == null) {
      throw ArgumentError('CommentReplyRoute requires CommentReplyRouteInput in \$extra');
    }
    return buildCommentReplyRoutePage(oid: oid, rootId: rootId, input: routeExtra);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildSearchRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<FavoritesRoute>(
  path: '/favorites',
  routes: [TypedGoRoute<FavoriteDetailRoute>(path: 'detail/:mediaId')],
)
class FavoritesRoute extends GoRouteData with $FavoritesRoute {
  const FavoritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildFavoritesRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class FavoriteDetailRoute extends GoRouteData with $FavoriteDetailRoute {
  final int mediaId;
  final String title;
  final int mid;

  const FavoriteDetailRoute({
    required this.mediaId,
    required this.title,
    required this.mid,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildFavoriteDetailRoutePage(mediaId: mediaId, title: title, mid: mid);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<FollowingsRoute>(path: '/followings/:vmid')
class FollowingsRoute extends GoRouteData with $FollowingsRoute {
  final int vmid;

  const FollowingsRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildFollowingsRoutePage(vmid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<FollowersRoute>(path: '/followers/:vmid')
class FollowersRoute extends GoRouteData with $FollowersRoute {
  final int vmid;

  const FollowersRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildFollowersRoutePage(vmid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<UserProfileRoute>(path: '/user/:mid')
class UserProfileRoute extends GoRouteData with $UserProfileRoute {
  final int mid;

  const UserProfileRoute({required this.mid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildUserProfileRoutePage(mid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildLoginRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildSettingsRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<ToViewRoute>(path: '/to-view')
class ToViewRoute extends GoRouteData with $ToViewRoute {
  const ToViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildToViewRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildHistoryRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}
