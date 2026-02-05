import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({required LocalKey key, required Widget child})
    : super(
        key: key,
        child: child,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              final a = CurveTween(curve: Curves.easeInOut).animate(animation);

              return FadeTransition(
                opacity: a,
                child: ScaleTransition(
                  scale: a.drive(Tween<double>(begin: 0.9, end: 1.0)),
                  child: child,
                ),
              );
            },
      );
}

class SlideFromBottomTransitionPage extends CustomTransitionPage {
  SlideFromBottomTransitionPage({required LocalKey key, required Widget child})
    : super(
        key: key,
        child: child,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              final tween = Tween(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
      );
}

class SlideFromRightTransitionPage extends CustomTransitionPage {
  SlideFromRightTransitionPage({required LocalKey key, required Widget child})
    : super(
        key: key,
        child: child,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              final tween = Tween(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
      );
}
