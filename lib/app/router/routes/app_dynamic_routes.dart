part of '../app_routes.dart';

@TypedGoRoute<DynamicDetailRoute>(path: '/dynamic/detail/:id')
class DynamicDetailRoute extends AppRouteData with $DynamicDetailRoute {
  final String id;

  const DynamicDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildDynamicNavigationScope(
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
      onOpenLiveRoom: (roomId) => LiveRoomRoute(roomId: roomId).push(context),
      onOpenDynamicDetail: (id) => DynamicDetailRoute(id: id).push(context),
      onOpenArticle: (url, title) => _pushArticleDetail(context, url: url, title: title),
      onOpenTopic: (topicId, topicName) =>
          _pushTopicDetail(context, topicId: topicId, topicName: topicName),
      child: DynamicDetailPage(dynamicId: id),
    );
  }
}

Widget _wrapDynamicNavigation(BuildContext context, {required Widget child}) {
  return buildDynamicNavigationScope(
    onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
    onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    onOpenLiveRoom: (roomId) => LiveRoomRoute(roomId: roomId).push(context),
    onOpenDynamicDetail: (id) => DynamicDetailRoute(id: id).push(context),
    onOpenArticle: (url, title) => _pushArticleDetail(context, url: url, title: title),
    onOpenTopic: (topicId, topicName) =>
        _pushTopicDetail(context, topicId: topicId, topicName: topicName),
    child: child,
  );
}

void _pushArticleDetail(BuildContext context, {required String url, String? title}) {
  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute(
      builder: (context) => buildArticleDetailRoutePage(url: url, title: title),
    ),
  );
}

void _pushTopicDetail(
  BuildContext context, {
  required int topicId,
  required String topicName,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => buildTopicDetailRoutePage(
        topicId: topicId,
        topicName: topicName,
        onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
        onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
        onOpenLiveRoom: (roomId) => LiveRoomRoute(roomId: roomId).push(context),
        onOpenDynamicDetail: (id) => DynamicDetailRoute(id: id).push(context),
        onOpenArticle: (url, title) =>
            _pushArticleDetail(context, url: url, title: title),
        onOpenTopic: (topicId, topicName) =>
            _pushTopicDetail(context, topicId: topicId, topicName: topicName),
      ),
    ),
  );
}

@TypedGoRoute<PublishDynamicRoute>(path: '/dynamic/publish')
class PublishDynamicRoute extends AppRouteData with $PublishDynamicRoute {
  const PublishDynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const PublishDynamicPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}
