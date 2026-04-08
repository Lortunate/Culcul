part of 'profile_app_bar.dart';

class _ExpBar extends StatelessWidget {
  final int current;
  final int? next;
  final int min;

  const _ExpBar({required this.current, this.next, required this.min});

  double _calculateProgress() {
    if (next != null && next! > min) {
      return ((current - min) / (next! - min)).clamp(0.0, 1.0);
    }
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = _calculateProgress();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.tertiary, colorScheme.primary],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          next != null ? '$current/$next' : '$current',
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 10,
            color: colorScheme.outline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
