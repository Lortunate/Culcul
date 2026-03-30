import 'package:culcul/features/video/domain/entities/video_models.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/presentation/widgets/comments/comment_images.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
import 'package:culcul/ui/widgets/app_selectable_text.dart';
import 'package:culcul/ui/widgets/bilibili_emoji_text.dart';
import 'package:culcul/ui/widgets/user_tags.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(url: item.member.avatar, size: 38),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(member: item.member, upperMid: upperMid),
                const SizedBox(height: 6),
                _Content(content: item.content, item: item),
                const SizedBox(height: 8),
                _Footer(
                  item: item,
                  onLike: onLike,
                  onDislike: onDislike,
                  onReply: onReply,
                ),
                if (showRepliesPreview && item.replies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _Replies(
                    replies: item.replies,
                    rcount: item.rcount,
                    onTap: onTapReplies,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final CommentMember member;
  final int? upperMid;

  const _Header({required this.member, this.upperMid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    final isVip = member.vip.vipStatus == 1;
    final isUpper = upperMid != null && member.mid == upperMid.toString();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            member.uname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isVip ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 6),
        if (member.levelInfo.currentLevel > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: LevelTag(level: member.levelInfo.currentLevel),
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
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

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

    List<InlineSpan> spans = [];

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
        emojiSize: 20,
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

class _Footer extends StatelessWidget {
  final CommentItem item;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onReply;

  const _Footer({required this.item, this.onLike, this.onDislike, this.onReply});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLiked = item.action == 1;

    return Row(
      children: [
        Text(
          FormatUtils.formatTimeAgo(item.ctime),
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        if (item.content.device.isNotEmpty) ...[
          const SizedBox(width: 12),
          Text(
            item.content.device,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const Spacer(),
        _Action(
          icon: isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
          color: isLiked ? colorScheme.primary : null,
          label: item.like > 0 ? FormatUtils.formatNumber(item.like) : '',
          onTap: onLike,
        ),
        const SizedBox(width: 16),
        _Action(icon: Icons.thumb_down_outlined, label: '', onTap: onDislike),
        const SizedBox(width: 16),
        _Action(icon: Icons.chat_bubble_outline_rounded, label: '', onTap: onReply),
        const SizedBox(width: 8),
        AppClickable(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.more_vert_rounded,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _Action({required this.icon, required this.label, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contentColor = color ?? theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
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
}

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

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...replies.take(2).map((reply) => _buildReplyItem(context, reply, theme)),
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
    );
  }
}
