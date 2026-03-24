part of '../video_card.dart';

class _VideoCardFooter extends StatelessWidget {
  final String author;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _VideoCardFooter({
    required this.author,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ),
        Icon(
          Icons.more_vert_rounded,
          size: 14,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}
