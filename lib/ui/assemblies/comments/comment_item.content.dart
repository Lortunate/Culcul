part of 'comment_item.dart';

class _Content extends StatelessWidget {
  final CommentContent content;
  final CommentItem item;

  const _Content({required this.content, required this.item});

  List<InlineSpan> _buildTextSpans(BuildContext context, ThemeData theme) {
    final t = Translations.of(context);
    final isReply = item.root != 0 && item.parent != 0 && item.parent != item.root;
    final textStyle =
        theme.textTheme.bodyMedium?.copyWith(
          height: 1.5,
          color: theme.colorScheme.onSurface,
        ) ??
        const TextStyle();

    final spans = <InlineSpan>[];

    if (isReply && content.members.isNotEmpty) {
      spans.add(
        TextSpan(
          text: t.video.reply_to(name: content.members.first.uname),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    spans.add(
      BilibiliEmojiText.buildEmojiTextSpan(
        text: content.message,
        emojiMap: content.emote ?? {},
        style: textStyle,
      ),
    );

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSelectableText.rich(
          TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: theme.colorScheme.onSurface,
            ),
            children: _buildTextSpans(context, theme),
          ),
        ),
        if (content.pictures.isNotEmpty) ...[
          const SizedBox(height: 8),
          CommentImagesWidget(pictures: content.pictures),
        ],
      ],
    );
  }
}
