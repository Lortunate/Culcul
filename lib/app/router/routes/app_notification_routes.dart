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
class NotificationRoute extends AppRouteData with $NotificationRoute {
  const NotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildNotificationRoutePage();
}

class ReplyNotificationRoute extends AppRouteData with $ReplyNotificationRoute {
  const ReplyNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildReplyNotificationRoutePage();
  }
}

class AtNotificationRoute extends AppRouteData with $AtNotificationRoute {
  const AtNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildAtNotificationRoutePage();
  }
}

class LikeNotificationRoute extends AppRouteData with $LikeNotificationRoute {
  const LikeNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildLikeNotificationRoutePage();
  }
}

class SystemNotificationRoute extends AppRouteData with $SystemNotificationRoute {
  const SystemNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildSystemNotificationRoutePage();
}

class ChatRoute extends AppRouteData with $ChatRoute {
  final int talkerId;
  final ChatRouteInput $extra;

  const ChatRoute({required this.talkerId, required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildChatRoutePage(talkerId: talkerId, input: $extra);
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
class DynamicDetailRoute extends AppRouteData with $DynamicDetailRoute {
  final String id;

  const DynamicDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildDynamicDetailRoutePage(id);
}

@TypedGoRoute<PublishDynamicRoute>(path: '/dynamic/publish')
class PublishDynamicRoute extends AppRouteData with $PublishDynamicRoute {
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
