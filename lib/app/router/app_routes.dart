import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/app/shell/main_shell.dart';
import 'package:culcul/features/auth/auth.dart';
import 'package:culcul/features/dynamic/dynamic.dart';
import 'package:culcul/features/favorites/favorites.dart';
import 'package:culcul/features/history/history.dart';
import 'package:culcul/features/home/home.dart';
import 'package:culcul/features/live/live.dart';
import 'package:culcul/features/notification/notification.dart';
import 'package:culcul/features/profile/profile.dart';
import 'package:culcul/features/ranking/ranking.dart';
import 'package:culcul/features/search/search.dart';
import 'package:culcul/features/settings/settings.dart';
import 'package:culcul/features/to_view/to_view.dart';
import 'package:culcul/features/video/video.dart';

import 'route_transitions.dart';

part 'app_routes.g.dart';
part 'routes/app_shell_routes.dart';
part 'routes/app_primary_routes.content_feed.dart';
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
