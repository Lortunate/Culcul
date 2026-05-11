part of '../app_routes.dart';

@TypedGoRoute<FollowingsRoute>(path: '/followings/:vmid')
class FollowingsRoute extends AppRouteData with $FollowingsRoute {
  final int vmid;

  const FollowingsRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildFollowingsRoutePage(vmid);
}

@TypedGoRoute<FollowersRoute>(path: '/followers/:vmid')
class FollowersRoute extends AppRouteData with $FollowersRoute {
  final int vmid;

  const FollowersRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildFollowersRoutePage(vmid);
}

@TypedGoRoute<UserProfileRoute>(path: '/user/:mid')
class UserProfileRoute extends AppRouteData with $UserProfileRoute {
  final int mid;

  const UserProfileRoute({required this.mid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildUserProfileRoutePage(mid);
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends AppRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildLoginRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  routes: [TypedGoRoute<AboutRoute>(path: 'about')],
)
class SettingsRoute extends AppRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildSettingsRoutePage();
}

class AboutRoute extends AppRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildAboutRoutePage();
}

@TypedGoRoute<ToViewRoute>(path: '/to-view')
class ToViewRoute extends AppRouteData with $ToViewRoute {
  const ToViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildToViewRoutePage();
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends AppRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildHistoryRoutePage();
}
