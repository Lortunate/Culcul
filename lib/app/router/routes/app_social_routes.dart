part of '../app_routes.dart';

@TypedGoRoute<FollowingsRoute>(path: '/followings/:vmid')
class FollowingsRoute extends AppRouteData with $FollowingsRoute {
  final int vmid;

  const FollowingsRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildFollowingsRoutePage(vmid, navigation: _profileRouteNavigation(context));
  }
}

@TypedGoRoute<FollowersRoute>(path: '/followers/:vmid')
class FollowersRoute extends AppRouteData with $FollowersRoute {
  final int vmid;

  const FollowersRoute({required this.vmid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildFollowersRoutePage(vmid, navigation: _profileRouteNavigation(context));
  }
}

@TypedGoRoute<UserProfileRoute>(path: '/user/:mid')
class UserProfileRoute extends AppRouteData with $UserProfileRoute {
  final int mid;

  const UserProfileRoute({required this.mid});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return buildUserProfileRoutePage(mid, navigation: _profileRouteNavigation(context));
  }
}

ProfileRouteNavigation _profileRouteNavigation(BuildContext context) {
  return ProfileRouteNavigation(
    onLogin: () => const LoginRoute().push(context),
    onOpenSettings: () => const SettingsRoute().push(context),
    onOpenHistory: () => const HistoryRoute().push(context),
    onOpenFavorites: () => const FavoritesRoute().push(context),
    onOpenToView: () => const ToViewRoute().push(context),
    onOpenFollowings: (vmid) => FollowingsRoute(vmid: vmid).push(context),
    onOpenFollowers: (vmid) => FollowersRoute(vmid: vmid).push(context),
    onOpenUser: (mid) => UserProfileRoute(mid: mid).push(context),
    onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    wrapDynamicNavigation: ({required child}) =>
        _wrapDynamicNavigation(context, child: child),
    onOpenChat: ({required talkerId, required name, avatarUrl}) {
      ChatRoute(
        talkerId: talkerId,
        $extra: ChatRouteInput(name: name, avatarUrl: avatarUrl),
      ).push(context);
    },
  );
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends AppRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: build(context, state),
      transitionDuration: CulculMotion.routeModal,
      reverseTransitionDuration: CulculMotion.routeReverse,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: CulculMotion.fadeScaleCurve,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1.0).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  routes: [TypedGoRoute<AboutRoute>(path: 'about')],
)
class SettingsRoute extends AppRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsPage(onOpenAbout: () => const AboutRoute().push(context));
  }
}

class AboutRoute extends AppRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AboutPage();
}

@TypedGoRoute<ToViewRoute>(path: '/to-view')
class ToViewRoute extends AppRouteData with $ToViewRoute {
  const ToViewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ToViewPage(
      onLogin: () => const LoginRoute().push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends AppRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HistoryPage(
      onLogin: () => const LoginRoute().push(context),
      onOpenVideo: (bvid) => VideoDetailRoute(bvid: bvid).push(context),
    );
  }
}
