part of '../app_routes.dart';

@TypedGoRoute<NotificationRoute>(
  path: '/notification',
  routes: [
    TypedGoRoute<ReplyNotificationRoute>(path: 'reply'),
    TypedGoRoute<AtNotificationRoute>(path: 'at'),
    TypedGoRoute<LikeNotificationRoute>(path: 'like'),
    TypedGoRoute<SystemNotificationRoute>(path: 'system'),
    TypedGoRoute<ChatRoute>(path: 'chat/:talkerId'),
  ],
)
class NotificationRoute extends GoRouteData with $NotificationRoute {
  const NotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildNotificationRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class ReplyNotificationRoute extends GoRouteData with $ReplyNotificationRoute {
  const ReplyNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildReplyNotificationRoutePage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class AtNotificationRoute extends GoRouteData with $AtNotificationRoute {
  const AtNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildAtNotificationRoutePage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class LikeNotificationRoute extends GoRouteData with $LikeNotificationRoute {
  const LikeNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildLikeNotificationRoutePage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class SystemNotificationRoute extends GoRouteData with $SystemNotificationRoute {
  const SystemNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildSystemNotificationRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class ChatRoute extends GoRouteData with $ChatRoute {
  final int talkerId;
  final String? name;
  final int? sessionType;
  final String? avatarUrl;

  const ChatRoute({required this.talkerId, this.name, this.sessionType, this.avatarUrl});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildChatRoutePage(
      talkerId: talkerId,
      name: name,
      sessionType: sessionType ?? 1,
      avatarUrl: avatarUrl,
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

@TypedGoRoute<DynamicDetailRoute>(path: '/dynamic/detail/:id')
class DynamicDetailRoute extends GoRouteData with $DynamicDetailRoute {
  final String id;

  const DynamicDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildDynamicDetailRoutePage(id);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<PublishDynamicRoute>(path: '/dynamic/publish')
class PublishDynamicRoute extends GoRouteData with $PublishDynamicRoute {
  const PublishDynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildPublishDynamicRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}
