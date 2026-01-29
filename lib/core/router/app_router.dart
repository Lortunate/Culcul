import 'package:cilixili/features/dynamic/dynamic_page.dart';
import 'package:cilixili/features/auth/login_page.dart';
import 'package:cilixili/features/settings/settings_page.dart';
import 'package:cilixili/features/home/pages/home_page.dart';
import 'package:cilixili/features/profile/profile_page.dart';
import 'package:cilixili/features/search/pages/search_page.dart';
import 'package:cilixili/features/subscription/subscription_page.dart';
import 'package:cilixili/features/video/pages/video_detail_page.dart';
import 'package:cilixili/features/main/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dynamic',
                builder: (context, state) => const DynamicPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/subscription',
                builder: (context, state) => const SubscriptionPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/video/:bvid',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final bvid = state.pathParameters['bvid']!;
          return VideoDetailPage(bvid: bvid);
        },
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
