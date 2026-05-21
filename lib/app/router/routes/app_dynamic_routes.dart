part of '../app_routes.dart';

@TypedGoRoute<DynamicDetailRoute>(path: '/dynamic/detail/:id')
class DynamicDetailRoute extends AppRouteData with $DynamicDetailRoute {
  final String id;

  const DynamicDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildDynamicDetailRoutePage(id);
}

@TypedGoRoute<PublishDynamicRoute>(path: '/dynamic/publish')
class PublishDynamicRoute extends AppRouteData with $PublishDynamicRoute {
  const PublishDynamicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      buildPublishDynamicRoutePage();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromBottomTransitionPage(
      key: state.pageKey,
      child: build(context, state),
    );
  }
}
