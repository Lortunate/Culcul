part of '../app_routes.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/home')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<DynamicRoute>(path: '/dynamic')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<RankingRoute>(path: '/ranking')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<ProfileRoute>(path: '/profile')]),
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

class HomeRoute extends AppRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildHomePage();
}

class DynamicRoute extends AppRouteData with $DynamicRoute {
  const DynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildDynamicRoutePage();
}

class RankingRoute extends AppRouteData with $RankingRoute {
  const RankingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildRankingRoutePage();
}

class ProfileRoute extends AppRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildProfileRoutePage();
}
