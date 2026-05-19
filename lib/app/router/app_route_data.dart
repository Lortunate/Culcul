import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:culcul/app/router/route_transitions.dart';

/// Base class for route data that provides a default [SlideFromRightTransitionPage]
/// transition. Subclasses only need to override [build] and can skip [buildPage]
/// unless they need a custom transition.
abstract class AppRouteData extends GoRouteData {
  const AppRouteData();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideFromRightTransitionPage(key: state.pageKey, child: build(context, state));
  }
}
