part of '../video_card.dart';

class _VideoCardContent extends StatelessWidget {
  final String title;
  final String author;
  final String? reason;
  final String? description;
  final bool showAuthor;
  final List<Widget>? extra;

  const _VideoCardContent({
    required this.title,
    required this.author,
    required this.reason,
    required this.description,
    required this.showAuthor,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _VideoCardTitle(title: title),
            if (reason?.isNotEmpty == true) ...[
              const SizedBox(height: 6),
              _VideoCardReasonTag(reason: reason!),
            ],
            if (description?.isNotEmpty == true) ...[
              const SizedBox(height: 4),
              _VideoCardDescription(description: description!),
            ],
            if (extra != null) ...extra!,
            const Spacer(),
            if (showAuthor) ...[
              const SizedBox(height: 6),
              _VideoCardFooter(author: author, colorScheme: colorScheme, theme: theme),
            ],
          ],
        ),
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

class _VideoCardReasonTag extends StatelessWidget {
  final String reason;

  const _VideoCardReasonTag({required this.reason});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppTag(
      text: reason,
      color: colorScheme.primaryContainer.withValues(alpha: 0.188),
      textColor: colorScheme.primary,
      fontSize: 10,
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
