part of '../comment_item.dart';

class _Replies extends StatelessWidget {
  final List<CommentItem> replies;
  final int rcount;
  final VoidCallback? onTap;

  const _Replies({required this.replies, required this.rcount, this.onTap});

  Widget _buildReplyItem(BuildContext context, CommentItem reply, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 13,
      height: 1.4,
      color: colorScheme.onSurface,
    );

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(
            text: '${reply.member.uname} ',
            style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
          ),
          BilibiliEmojiText.buildEmojiTextSpan(
            text: reply.content.message,
            emojiMap: reply.content.emote ?? {},
            style: textStyle ?? const TextStyle(),
            emojiSize: 14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: theme.scaffoldBackgroundColor,
        child: AppClickable(
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...replies
                      .take(2)
                      .map((reply) => _buildReplyItem(context, reply, theme)),
                  if (rcount > 2)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          Text(
                            t.video.comment.replies(count: rcount),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 14,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
