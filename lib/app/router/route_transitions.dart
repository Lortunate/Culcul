import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A fade transition with a subtle scale effect, ideal for modal-like pages
class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({required LocalKey super.key, required super.child})
    : super(
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              final fadeTween = CurveTween(curve: Curves.easeInOut).animate(animation);
              final scaleTween = CurveTween(curve: Curves.easeInOut).animate(animation);

              return FadeTransition(
                opacity: fadeTween,
                child: ScaleTransition(
                  scale: scaleTween.drive(Tween<double>(begin: 0.98, end: 1.0)),
                  child: child,
                ),
              );
            },
      );
}

/// A slide transition from the bottom, perfect for modals and bottom sheets
class SlideFromBottomTransitionPage extends CustomTransitionPage {
  SlideFromBottomTransitionPage({required LocalKey super.key, required super.child})
    : super(
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              final tween = Tween(
                begin: const Offset(0.0, 0.2),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOut));

              return SlideTransition(
                position: animation.drive(tween),
                child: FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeOut)),
                  child: child,
                ),
              );
            },
      );
}

/// A slide transition from the right, ideal for navigational pages
class SlideFromRightTransitionPage extends CustomTransitionPage {
  SlideFromRightTransitionPage({required LocalKey super.key, required super.child})
    : super(
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

              return SlideTransition(position: animation.drive(tween), child: child);
            },
      );
}

/// A slide transition from the left, useful for backward navigation
class SlideFromLeftTransitionPage extends CustomTransitionPage {
  SlideFromLeftTransitionPage({required LocalKey super.key, required super.child})
    : super(
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              final tween = Tween(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut));

              return SlideTransition(position: animation.drive(tween), child: child);
            },
      );
}
