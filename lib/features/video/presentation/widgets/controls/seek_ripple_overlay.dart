import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SeekRippleOverlay extends HookWidget {
  final bool isForward;
  final VoidCallback onAnimationComplete;

  const SeekRippleOverlay({
    super.key,
    required this.isForward,
    required this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    useEffect(() {
      controller.forward().then((_) => onAnimationComplete());
      return null;
    }, const []);

    return ClipPath(
      clipper: _RippleClipper(isForward: isForward),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Opacity(
            opacity: 1.0 - controller.value,
            child: Container(
              color: Colors.white.withValues(alpha: 0.2),
              alignment: isForward ? Alignment.centerRight : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isForward ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '10s',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RippleClipper extends CustomClipper<Path> {
  final bool isForward;

  _RippleClipper({required this.isForward});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isForward) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.quadraticBezierTo(size.width * 0.6, size.height / 2, size.width, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.quadraticBezierTo(size.width * 0.4, size.height / 2, 0, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
