import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/data/models/comment/comment_model.dart';
import 'package:culcul/features/favorites/presentation/favorite_detail_page.dart';
import 'package:culcul/features/favorites/presentation/favorites_page.dart';
import 'package:culcul/features/home/presentation/home_page.dart';
import 'package:culcul/features/home/presentation/weekly/weekly_screen.dart';
import 'package:culcul/features/history/presentation/history_page.dart';
import 'package:culcul/features/live/presentation/live_room_page.dart';
import 'package:culcul/features/notification/presentation/chat_page.dart';
import 'package:culcul/features/notification/presentation/notification_list_page.dart';
import 'package:culcul/features/notification/presentation/notification_page.dart';
import 'package:culcul/features/notification/presentation/system_notification_page.dart';
import 'package:culcul/features/profile/presentation/profile_page.dart';
import 'package:culcul/features/profile/presentation/relation/followers_page.dart';
import 'package:culcul/features/profile/presentation/relation/followings_page.dart';
import 'package:culcul/features/profile/presentation/user_profile_page.dart';
import 'package:culcul/features/ranking/presentation/ranking_page.dart';
import 'package:culcul/features/scanner/presentation/scanner_page.dart';
import 'package:culcul/features/search/presentation/search_page.dart';
import 'package:culcul/features/settings/presentation/settings_page.dart';
import 'package:culcul/features/to_view/presentation/to_view_page.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_page.dart';
import 'package:culcul/features/dynamic/presentation/publish_dynamic_page.dart';
import 'package:culcul/features/video/presentation/comment_reply_page.dart';
import 'package:culcul/features/video/presentation/video_detail_page.dart';
import 'package:culcul/features/auth/presentation/login_page.dart';
import 'package:culcul/app/shell/main_shell.dart';

import 'route_transitions.dart';

part 'app_routes.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    routes: $appRoutes,
    debugLogDiagnostics: true,
  );
}

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/home')]),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<DynamicRoute>(path: '/dynamic')],
    ),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<RankingRoute>(path: '/ranking')],
    ),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<ProfileRoute>(path: '/profile')],
    ),
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

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class DynamicRoute extends GoRouteData with $DynamicRoute {
  const DynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DynamicPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

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
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class RankingRoute extends GoRouteData with $RankingRoute {
  const RankingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RankingPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<WeeklyRoute>(path: '/weekly')
class WeeklyRoute extends GoRouteData with $WeeklyRoute {
  const WeeklyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WeeklyScreen();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<VideoDetailRoute>(path: '/video/:bvid')
class VideoDetailRoute extends GoRouteData with $VideoDetailRoute {
  final String bvid;

  const VideoDetailRoute({required this.bvid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VideoDetailPage(bvid: bvid);
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
class LiveRoomRoute extends GoRouteData with $LiveRoomRoute {
  final int roomId;

  const LiveRoomRoute({required this.roomId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LiveRoomPage(roomId: roomId);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<CommentReplyRoute>(path: '/comment/reply')
class CommentReplyRoute extends GoRouteData with $CommentReplyRoute {
  final String bvid;
  final int oid;
  final int rootId;
  final dynamic $extra;

  const CommentReplyRoute({
    required this.bvid,
    required this.oid,
    required this.rootId,
    this.$extra,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if ($extra is Map<String, dynamic>) {
      final map = $extra as Map<String, dynamic>;
      return CommentReplyPage(
        oid: oid,
        rootId: rootId,
        comment: map['comment'] as CommentItem,
        upperMid: map['upperMid'] as int?,
      );
    }
    return CommentReplyPage(
      oid: oid,
      rootId: rootId,
      comment: $extra as CommentItem,
    );
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<FavoritesRoute>(
  path: '/favorites',
  routes: [TypedGoRoute<FavoriteDetailRoute>(path: 'detail/:mediaId')],
)
class FavoritesRoute extends GoRouteData with $FavoritesRoute {
  const FavoritesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoritesPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
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
    return FavoriteDetailPage(mediaId: mediaId, title: title, mid: mid);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<FollowingsRoute>(path: '/followings/:vmid')
class FollowingsRoute extends GoRouteData with $FollowingsRoute {
  final int vmid;
  const FollowingsRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FollowingsPage(vmid: vmid);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<FollowersRoute>(path: '/followers/:vmid')
class FollowersRoute extends GoRouteData with $FollowersRoute {
  final int vmid;
  const FollowersRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FollowersPage(vmid: vmid);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<UserProfileRoute>(path: '/user/:mid')
class UserProfileRoute extends GoRouteData with $UserProfileRoute {
  final int mid;
  const UserProfileRoute({required this.mid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserProfilePage(mid: mid);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<ToViewRoute>(path: '/to_view')
class ToViewRoute extends GoRouteData with $ToViewRoute {
  const ToViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ToViewPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HistoryPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class ReplyNotificationRoute extends GoRouteData with $ReplyNotificationRoute {
  const ReplyNotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationListPage(type: NotificationType.reply);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class AtNotificationRoute extends GoRouteData with $AtNotificationRoute {
  const AtNotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationListPage(type: NotificationType.at);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class LikeNotificationRoute extends GoRouteData with $LikeNotificationRoute {
  const LikeNotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationListPage(type: NotificationType.like);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class SystemNotificationRoute extends GoRouteData
    with $SystemNotificationRoute {
  const SystemNotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SystemNotificationPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

class ChatRoute extends GoRouteData with $ChatRoute {
  final int talkerId;
  final String? name;
  final int? sessionType;
  final String? avatarUrl;

  const ChatRoute({
    required this.talkerId,
    this.name,
    this.sessionType,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) => ChatPage(
    talkerId: talkerId,
    name: name,
    sessionType: sessionType ?? 1,
    avatarUrl: avatarUrl,
  );

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<ScannerRoute>(path: '/scan')
class ScannerRoute extends GoRouteData with $ScannerRoute {
  const ScannerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ScannerPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
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
  Widget build(BuildContext context, GoRouterState state) {
    return DynamicDetailPage(dynamicId: id);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}

@TypedGoRoute<PublishDynamicRoute>(path: '/dynamic/publish')
class PublishDynamicRoute extends GoRouteData with $PublishDynamicRoute {
  const PublishDynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PublishDynamicPage();
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}
