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

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class DynamicRoute extends GoRouteData with $DynamicRoute {
  const DynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DynamicPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class RankingRoute extends GoRouteData with $RankingRoute {
  const RankingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RankingPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}
