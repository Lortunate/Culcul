import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned.fill(child: Container(color: theme.colorScheme.surface)),
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  theme.colorScheme.primary.withValues(
                    alpha: isDark ? 0.2 : 0.1,
                  ),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: -50,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  theme.colorScheme.secondary.withValues(
                    alpha: isDark ? 0.2 : 0.1,
                  ),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
