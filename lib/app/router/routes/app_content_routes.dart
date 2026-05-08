part of '../app_routes.dart';

@TypedGoRoute<FollowingsRoute>(path: '/followings/:vmid')
class FollowingsRoute extends GoRouteData with $FollowingsRoute {
  final int vmid;

  const FollowingsRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildFollowingsRoutePage(vmid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<FollowersRoute>(path: '/followers/:vmid')
class FollowersRoute extends GoRouteData with $FollowersRoute {
  final int vmid;

  const FollowersRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildFollowersRoutePage(vmid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<UserProfileRoute>(path: '/user/:mid')
class UserProfileRoute extends GoRouteData with $UserProfileRoute {
  final int mid;

  const UserProfileRoute({required this.mid});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildUserProfileRoutePage(mid);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
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
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildSettingsRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

class AboutRoute extends GoRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildAboutRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<ToViewRoute>(path: '/to-view')
class ToViewRoute extends GoRouteData with $ToViewRoute {
  const ToViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildToViewRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => buildHistoryRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}
