import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/pages/video/widgets/comment_images.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentItem item;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onReply;
  final bool showRepliesPreview;
  final VoidCallback? onTapReplies;
  final int? upperMid;

  const CommentItemWidget({
    super.key,
    required this.item,
    this.onLike,
    this.onDislike,
    this.onReply,
    this.showRepliesPreview = true,
    this.onTapReplies,
    this.upperMid,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(theme),
                const SizedBox(height: 6),
                _buildContent(context, theme),
                const SizedBox(height: 8),
                _buildFooter(context, theme),
                if (showRepliesPreview && item.replies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildReplies(context, theme),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return AppAvatar(url: item.member.avatar, size: 38);
  }

  Widget _buildHeader(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final isVip = item.member.vip.vipStatus == 1;
    final isUpper = upperMid != null && item.member.mid == upperMid.toString();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            item.member.uname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isVip ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 6),
        if (item.member.level_info.current_level > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: LevelTag(level: item.member.level_info.current_level),
          ),
        if (isUpper)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0.5),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              t.common.up,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 9,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final content = item.content;
    final message = content.message;
    final emote = content.emote;
    final members = content.members;
    final isReply =
        item.root != 0 && item.parent != 0 && item.parent != item.root;

    List<InlineSpan> spans = [];

    if (isReply && members.isNotEmpty) {
      spans.add(
        TextSpan(
          text: t.video.reply_to(name: members.first.uname),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    spans.add(
      BilibiliEmojiText.buildEmojiTextSpan(
        text: message,
        emojiMap: emote ?? {},
        style:
            theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: theme.colorScheme.onSurface,
            ) ??
            const TextStyle(),
        emojiSize: 20,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
              color: theme.colorScheme.onSurface,
            ),
            children: spans,
          ),
        ),
        if (item.content.pictures.isNotEmpty) ...[
          const SizedBox(height: 8),
          CommentImagesWidget(pictures: item.content.pictures),
        ],
      ],
    );
  }

  Widget _buildFooter(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    final isLiked = item.action == 1;

    return Row(
      children: [
        Text(
          FormatUtils.formatTimestamp(item.ctime),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (item.content.device.isNotEmpty) ...[
          const SizedBox(width: 12),
          Text(
            item.content.device,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const Spacer(),
        _buildAction(
          context: context,
          icon: isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
          color: isLiked ? colorScheme.primary : null,
          label: item.like > 0 ? FormatUtils.formatNumber(item.like) : '',
          onTap: onLike,
        ),
        const SizedBox(width: 16),
        _buildAction(
          context: context,
          icon: Icons.thumb_down_outlined,
          label: '',
          onTap: onDislike,
        ),
        const SizedBox(width: 16),
        _buildAction(
          context: context,
          icon: Icons.chat_bubble_outline_rounded,
          label: '',
          onTap: onReply,
        ),
        const SizedBox(width: 8),
        AppClickable(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.more_vert_rounded,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAction({
    required BuildContext context,
    required IconData icon,
    required String label,
    Color? color,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final contentColor = color ?? theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: contentColor),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: contentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReplies(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return AppClickable(
      onTap: onTapReplies,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...item.replies.take(2).map((reply) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      height: 1.4,
                      color: colorScheme.onSurface,
                    ),
                    children: [
                      TextSpan(
                        text: '${reply.member.uname} ',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BilibiliEmojiText.buildEmojiTextSpan(
                        text: reply.content.message,
                        emojiMap: reply.content.emote ?? {},
                        style:
                            theme.textTheme.bodySmall?.copyWith(
                              fontSize: 13,
                              height: 1.4,
                              color: colorScheme.onSurface,
                            ) ??
                            const TextStyle(),
                        emojiSize: 14,
                      ),
                    ],
                  ),
                ),
              );
            }),
            if (item.rcount > 2)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  children: [
                    Text(
                      t.video.replies(count: item.rcount),
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
    );
  }
}
