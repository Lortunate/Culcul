part of '../app_routes.dart';

@TypedGoRoute<WeeklyRoute>(path: '/weekly')
class WeeklyRoute extends AppRouteData with $WeeklyRoute {
  const WeeklyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildWeeklyScreenPage(
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}

@TypedGoRoute<VideoDetailRoute>(path: '/video/:bvid')
class VideoDetailRoute extends AppRouteData with $VideoDetailRoute {
  final String bvid;

  const VideoDetailRoute({required this.bvid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildVideoDetailRoutePage(
      bvid,
      onLogin: () => const LoginRoute().push(context),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
      onOpenCommentReplies:
          ({required oid, required rootId, required comment, upperMid}) {
            CommentReplyRoute(
              bvid: bvid,
              oid: oid,
              rootId: rootId,
              $extra: CommentReplyRouteInput(comment: comment, upperMid: upperMid),
            ).push(context);
          },
    );
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<LiveRoomRoute>(path: '/live/:roomId')
class LiveRoomRoute extends AppRouteData with $LiveRoomRoute {
  final int roomId;

  const LiveRoomRoute({required this.roomId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildLiveRoomRoutePage(
      roomId: roomId,
      onLogin: () => const LoginRoute().push(context),
    );
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<CommentReplyRoute>(path: '/video/:bvid/comment/:oid/:rootId')
class CommentReplyRoute extends AppRouteData with $CommentReplyRoute {
  final String bvid;
  final int oid;
  final int rootId;
  final CommentReplyRouteInput $extra;

  const CommentReplyRoute({
    required this.bvid,
    required this.oid,
    required this.rootId,
    required this.$extra,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildCommentReplyRoutePage(
      oid: oid,
      rootId: rootId,
      input: $extra,
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
    );
  }
}

@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends AppRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildSearchRoutePage(
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
      onOpenTopic: (topicId, topicName) =>
          _pushTopicDetail(context, topicId: topicId, topicName: topicName),
    );
  }
}

@TypedGoRoute<FavoritesRoute>(
  path: '/favorites',
  routes: [TypedGoRoute<FavoriteDetailRoute>(path: 'detail/:mediaId')],
)
class FavoritesRoute extends AppRouteData with $FavoritesRoute {
  const FavoritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildFavoritesRoutePage(
      onLogin: () => const LoginRoute().push(context),
      onOpenFolder: (folder) {
        FavoriteDetailRoute(
          mediaId: folder.id,
          title: folder.title,
          mid: folder.mid,
        ).push(context);
      },
    );
  }
}

class FavoriteDetailRoute extends AppRouteData with $FavoriteDetailRoute {
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
}
