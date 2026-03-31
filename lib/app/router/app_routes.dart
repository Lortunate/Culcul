import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:culcul/app/shell/main_shell.dart';
import 'package:culcul/features/auth/presentation/route_entry.dart';
import 'package:culcul/features/dynamic/presentation/route_entry.dart';
import 'package:culcul/features/favorites/presentation/route_entry.dart';
import 'package:culcul/features/history/presentation/route_entry.dart';
import 'package:culcul/features/home/presentation/route_entry.dart';
import 'package:culcul/features/live/presentation/route_entry.dart';
import 'package:culcul/features/notification/presentation/route_entry.dart';
import 'package:culcul/features/profile/presentation/route_entry.dart';
import 'package:culcul/features/ranking/presentation/route_entry.dart';
import 'package:culcul/features/search/presentation/route_entry.dart';
import 'package:culcul/features/settings/presentation/route_entry.dart';
import 'package:culcul/features/to_view/presentation/route_entry.dart';
import 'package:culcul/features/video/presentation/route_entry.dart';

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

