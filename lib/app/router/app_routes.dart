import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/app/shell/main_shell.dart';
import 'package:culcul/features/auth/presentation/auth_route_entry.dart';
import 'package:culcul/features/dynamic/presentation/dynamic_route_entry.dart';
import 'package:culcul/features/favorites/presentation/favorites_route_entry.dart';
import 'package:culcul/features/history/presentation/history_route_entry.dart';
import 'package:culcul/features/home/presentation/home_route_entry.dart';
import 'package:culcul/features/live/presentation/live_route_entry.dart';
import 'package:culcul/features/notification/presentation/notification_route_entry.dart';
import 'package:culcul/features/profile/presentation/profile_route_entry.dart';
import 'package:culcul/features/ranking/presentation/ranking_route_entry.dart';
import 'package:culcul/features/search/presentation/search_route_entry.dart';
import 'package:culcul/features/settings/presentation/settings_route_entry.dart';
import 'package:culcul/features/to_view/presentation/to_view_route_entry.dart';
import 'package:culcul/features/video/presentation/video_route_entry.dart';

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
