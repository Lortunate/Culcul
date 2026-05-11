import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/app/shell/main_shell.dart';
import 'package:culcul/features/auth/route_entry.dart';
import 'package:culcul/features/dynamic/route_entry.dart';
import 'package:culcul/features/favorites/route_entry.dart';
import 'package:culcul/features/history/route_entry.dart';
import 'package:culcul/features/home/route_entry.dart';
import 'package:culcul/features/live/route_entry.dart';
import 'package:culcul/features/notification/route_entry.dart';
export 'package:culcul/features/notification/route_entry.dart' show ChatRouteInput;
import 'package:culcul/features/profile/route_entry.dart';
import 'package:culcul/features/ranking/route_entry.dart';
import 'package:culcul/features/search/route_entry.dart';
import 'package:culcul/features/settings/route_entry.dart';
import 'package:culcul/features/to_view/route_entry.dart';
import 'package:culcul/features/video/route_entry.dart';

import 'app_route_data.dart';
import 'route_transitions.dart';

part 'app_routes.g.dart';
part 'routes/app_shell_routes.dart';
part 'routes/app_social_routes.dart';
part 'routes/app_content_routes.dart';
part 'routes/app_notification_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
  );
}
