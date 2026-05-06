part of '../guest_view.dart';

class _GuestIllustration extends StatelessWidget {
  const _GuestIllustration();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _GuestGlow(colorScheme: colorScheme),
          _GuestBadgeBackground(colorScheme: colorScheme),
          Icon(Icons.lock_person_rounded, size: 56, color: colorScheme.primary),
          Positioned(
            top: 40,
            right: 40,
            child: _DecorativeDot(
              size: 8,
              color: colorScheme.secondary.withValues(alpha: 0.8),
            ),
          ),
          Positioned(
            bottom: 45,
            left: 45,
            child: _DecorativeDot(
              size: 6,
              color: colorScheme.tertiary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestGlow extends StatelessWidget {
  final ColorScheme colorScheme;

  const _GuestGlow({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.15),
            colorScheme.primary.withValues(alpha: 0.0),
          ],
          stops: const [0.3, 1.0],
        ),
      ),
    );
  }
}

class _GuestBadgeBackground extends StatelessWidget {
  final ColorScheme colorScheme;

  const _GuestBadgeBackground({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _DecorativeDot extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorativeDot({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
