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
part 'routes/app_shell_routes.dart';
part 'routes/app_primary_routes.dart';
part 'routes/app_secondary_routes.dart';

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
