part of '../video_card.dart';

class _VideoCardContent extends StatelessWidget {
  final String title;
  final String author;
  final String? description;
  final bool showAuthor;
  final List<Widget> extra;

  const _VideoCardContent({
    required this.title,
    required this.author,
    this.description,
    this.showAuthor = true,
    this.extra = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VideoCardTitle(title: title),
          if (description?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            _VideoCardDescription(description: description!),
          ],
          ...extra,
          const Spacer(),
          if (showAuthor) _VideoCardFooter(author: author),
        ],
      ),
    );
  }
}

class _VideoCardTitle extends StatelessWidget {
  final String title;

  const _VideoCardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.25,
        fontSize: 13,
        color: colorScheme.onSurface,
      ),
    );
  }
}

class _VideoCardDescription extends StatelessWidget {
  final String description;

  const _VideoCardDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 11,
      ),
    );
  }
}
