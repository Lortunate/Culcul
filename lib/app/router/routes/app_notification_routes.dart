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
  Widget build(BuildContext context, GoRouterState state) {
    return buildNotificationRoutePage(
      onLogin: () => const LoginRoute().push(context),
      onOpenReply: () => const ReplyNotificationRoute().push(context),
      onOpenAt: () => const AtNotificationRoute().push(context),
      onOpenLike: () => const LikeNotificationRoute().push(context),
      onOpenSystem: () => const SystemNotificationRoute().push(context),
      onOpenChat: (session, {required name, required avatarUrl}) {
        ChatRoute(
          talkerId: session.talkerId,
          $extra: ChatRouteInput(
            name: name,
            sessionType: session.sessionType,
            avatarUrl: avatarUrl,
          ),
        ).push(context);
      },
    );
  }
}

class ReplyNotificationRoute extends AppRouteData with $ReplyNotificationRoute {
  const ReplyNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildReplyNotificationRoutePage(
      onOpenTarget: (target) => _openNotificationTarget(context, target),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
    );
  }
}

class AtNotificationRoute extends AppRouteData with $AtNotificationRoute {
  const AtNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildAtNotificationRoutePage(
      onOpenTarget: (target) => _openNotificationTarget(context, target),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
    );
  }
}

class LikeNotificationRoute extends AppRouteData with $LikeNotificationRoute {
  const LikeNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildLikeNotificationRoutePage(
      onOpenTarget: (target) => _openNotificationTarget(context, target),
      onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
    );
  }
}

class SystemNotificationRoute extends AppRouteData with $SystemNotificationRoute {
  const SystemNotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildSystemNotificationRoutePage(
      onOpenTarget: (target) => _openNotificationTarget(context, target),
    );
  }
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

Future<bool> _openNotificationTarget(
  BuildContext context,
  NotificationNavigationTarget target,
) {
  return openNotificationNavigationTarget(
    target,
    onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    onOpenDynamic: (id) => DynamicDetailRoute(id: id).push(context),
  );
}
