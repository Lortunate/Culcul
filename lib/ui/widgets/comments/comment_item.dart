import 'package:culcul/core/models/comment_contract.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/text/bilibili_emoji_text.dart';
import 'package:culcul/ui/widgets/users/user_tags.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/media/app_image_preview.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentItem item;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onReply;
  final bool showRepliesPreview;
  final VoidCallback? onTapReplies;
  final ValueChanged<int>? onTapUser;
  final int? upperMid;

  const CommentItemWidget({
    super.key,
    required this.item,
    this.onLike,
    this.onDislike,
    this.onReply,
    this.showRepliesPreview = true,
    this.onTapReplies,
    this.onTapUser,
    this.upperMid,
  });

  @override
  Widget build(BuildContext context) {
    void handleTapUser() {
      final mid = int.tryParse(item.member.mid);
      if (mid == null || mid <= 0) {
        return;
      }
      onTapUser?.call(mid);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(url: item.member.avatar, size: 38, onTap: handleTapUser),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  member: item.member,
                  upperMid: upperMid,
                  onTapUser: handleTapUser,
                ),
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
  final VoidCallback? onTapUser;

  const _Header({required this.member, this.upperMid, this.onTapUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    final isVip = member.vip.vipStatus == 1;
    final isUpper = upperMid != null && member.mid == upperMid.toString();

    return Row(
      children: [
        Flexible(
          child: AppClickable(
            onTap: onTapUser,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    final isReply = item.root != 0 && item.parent != 0 && item.parent != item.root;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      height: 1.5,
      color: theme.colorScheme.onSurface,
    );
    final textSpans = <InlineSpan>[
      if (isReply && content.members.isNotEmpty)
        TextSpan(
          text: t.video.reply_to(name: content.members.first.uname),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      BilibiliEmojiText.buildEmojiTextSpan(
        text: content.message,
        emojiMap: content.emote ?? {},
        style: textStyle ?? const TextStyle(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText.rich(
          TextSpan(style: textStyle, children: textSpans),
          scrollPhysics: const NeverScrollableScrollPhysics(),
        ),
        if (content.pictures.isNotEmpty) ...[
          const SizedBox(height: 8),
          _CommentImages(pictures: content.pictures),
        ],
      ],
    );
  }
}

class _CommentImages extends StatelessWidget {
  static const int _maxDecodeDimension = 2048;

  final List<CommentPicture> pictures;

  const _CommentImages({required this.pictures});

  @override
  Widget build(BuildContext context) {
    if (pictures.isEmpty) return const SizedBox.shrink();

    final imageUrls = pictures.map((p) => p.imgSrc).toList();

    Widget? buildLoadState(ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Container(color: Theme.of(context).colorScheme.surfaceContainerHigh);
        case LoadState.completed:
          return null;
        case LoadState.failed:
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: const Icon(Icons.broken_image, size: 20),
          );
      }
    }

    void openPreview(int index) {
      AppImagePreview.open(context, imageUrls: imageUrls, initialIndex: index);
    }

    int toCacheDimension(double logicalSize, double devicePixelRatio) {
      final scaled = (logicalSize * devicePixelRatio).round();
      if (scaled <= 0) return 1;
      return scaled > _maxDecodeDimension ? _maxDecodeDimension : scaled;
    }

    if (pictures.length == 1) {
      final picture = pictures.first;
      final double? w = picture.imgWidth > 0 ? picture.imgWidth : null;
      final double? h = picture.imgHeight > 0 ? picture.imgHeight : null;

      double aspectRatio = 1.0;
      if (w != null && h != null && h > 0) {
        aspectRatio = w / h;
      }

      const double maxSide = 200.0;
      const double minSide = 100.0;
      final Size displaySize;
      if (aspectRatio >= 1.0) {
        final height = (maxSide / aspectRatio).clamp(minSide, maxSide);
        displaySize = Size(maxSide, height);
      } else {
        final width = (maxSide * aspectRatio).clamp(minSide, maxSide);
        displaySize = Size(width, maxSide);
      }
      final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

      return GestureDetector(
        onTap: () => openPreview(0),
        child: Hero(
          tag: picture.imgSrc,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: maxSide,
              maxHeight: maxSide,
              minWidth: minSide,
              minHeight: minSide,
            ),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: ExtendedImage.network(
                FormatUtils.formatImageUrl(picture.imgSrc),
                fit: BoxFit.cover,
                cacheWidth: toCacheDimension(displaySize.width, devicePixelRatio),
                cacheHeight: toCacheDimension(displaySize.height, devicePixelRatio),
                borderRadius: BorderRadius.circular(8),
                loadStateChanged: buildLoadState,
              ),
            ),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const int crossAxisCount = 3;
        const double spacing = 8.0;
        final double totalWidth = constraints.maxWidth;
        final double itemSize =
            (totalWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
        final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
        final decodeSize = toCacheDimension(itemSize, devicePixelRatio);

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(pictures.length, (index) {
            final picture = pictures[index];
            return GestureDetector(
              onTap: () => openPreview(index),
              child: Hero(
                tag: picture.imgSrc,
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: ExtendedImage.network(
                    FormatUtils.formatImageUrl(picture.imgSrc),
                    fit: BoxFit.cover,
                    cacheWidth: decodeSize,
                    cacheHeight: decodeSize,
                    borderRadius: BorderRadius.circular(8),
                    loadStateChanged: buildLoadState,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _Replies extends StatelessWidget {
  final List<CommentItem> replies;
  final int rcount;
  final VoidCallback? onTap;

  const _Replies({required this.replies, required this.rcount, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final replyTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 13,
      height: 1.4,
      color: colorScheme.onSurface,
    );

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
                  for (final reply in replies.take(2))
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: replyTextStyle,
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
                            style: replyTextStyle ?? const TextStyle(),
                            emojiSize: 14,
                          ),
                        ],
                      ),
                    ),
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
        if (onDislike != null) ...[
          _Action(icon: Icons.thumb_down_outlined, label: '', onTap: onDislike),
          const SizedBox(width: 16),
        ],
        _Action(icon: Icons.chat_bubble_outline_rounded, label: '', onTap: onReply),
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
