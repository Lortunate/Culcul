import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class AuthBackground extends StatefulWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // Slower, smoother animation
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Optimized colors for better background blend
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final tertiaryColor = theme.colorScheme.tertiary;

    return Stack(
      children: [
        // Base background - subtle off-white/dark surface
        Positioned.fill(
          child: Container(
            color: isDark 
                ? theme.colorScheme.surface 
                : theme.colorScheme.surfaceContainerLow,
          ),
        ),
        
        // Animated Blob 1 (Top Right)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: -120 + sin(_controller.value * 2 * pi) * 30,
              right: -100 + cos(_controller.value * 2 * pi) * 30,
              child: child!,
            );
          },
          child: Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryColor.withValues(alpha: isDark ? 0.25 : 0.15),
                  primaryColor.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
        ),

        // Animated Blob 2 (Bottom Left)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              bottom: -150 + cos(_controller.value * 2 * pi) * 40,
              left: -80 + sin(_controller.value * 2 * pi) * 40,
              child: child!,
            );
          },
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  secondaryColor.withValues(alpha: isDark ? 0.25 : 0.15),
                  secondaryColor.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
        ),

        // Animated Blob 3 (Center - subtle accent)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: MediaQuery.of(context).size.height * 0.25 + 
                   sin(_controller.value * 2 * pi) * 60,
              left: MediaQuery.of(context).size.width * 0.1 + 
                   cos(_controller.value * 2 * pi) * 40,
              child: child!,
            );
          },
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  tertiaryColor.withValues(alpha: isDark ? 0.2 : 0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Stronger blur for a smoother, cleaner look
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),

        // Content
        Positioned.fill(child: widget.child),
      ],
    );
  }
}
