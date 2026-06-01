import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/app/shell/main_shell.dart';
import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/features/auth/presentation/pages/login_page.dart';
import 'package:culcul/features/dynamic/navigation.dart';
import 'package:culcul/features/dynamic/presentation/pages/dynamic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/pages/dynamic_page.dart';
import 'package:culcul/features/dynamic/presentation/pages/publish_dynamic_page.dart';
import 'package:culcul/features/favorites/presentation/pages/favorite_detail_page.dart';
import 'package:culcul/features/favorites/presentation/pages/favorites_page.dart';
import 'package:culcul/features/history/presentation/pages/history_page.dart';
import 'package:culcul/features/home/presentation/pages/home_page.dart';
import 'package:culcul/features/home/presentation/pages/weekly_screen.dart';
import 'package:culcul/features/live/presentation/pages/live_room_page.dart';
import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/presentation/pages/chat_page.dart';
import 'package:culcul/features/notification/presentation/pages/notification_list_page.dart';
import 'package:culcul/features/notification/presentation/pages/notification_page.dart';
import 'package:culcul/features/notification/presentation/pages/system_notification_page.dart';
import 'package:culcul/features/profile/navigation.dart';
import 'package:culcul/features/ranking/presentation/pages/ranking_page.dart';
import 'package:culcul/features/search/presentation/pages/search_page.dart';
import 'package:culcul/features/settings/presentation/pages/about_page.dart';
import 'package:culcul/features/settings/presentation/pages/settings_page.dart';
import 'package:culcul/features/to_view/presentation/pages/to_view_page.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_page.dart';
import 'package:culcul/features/video/presentation/detail/video_entry_decision_page.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';

import 'package:culcul/app/router/app_route_data.dart';
import 'package:culcul/app/router/route_transitions.dart';

part 'app_routes.g.dart';
part 'routes/app_shell_routes.dart';
part 'routes/app_social_routes.dart';
part 'routes/app_content_routes.dart';
part 'routes/app_dynamic_routes.dart';
part 'routes/app_notification_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class CommentReplyRouteInput {
  final CommentItem comment;
  final int? upperMid;

  const CommentReplyRouteInput({required this.comment, this.upperMid});
}

class ChatRouteInput {
  final String? name;
  final PrivateSessionType sessionType;
  final String? avatarUrl;

  const ChatRouteInput({
    this.name,
    this.sessionType = PrivateSessionType.user,
    this.avatarUrl,
  });
}

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
  );
}
