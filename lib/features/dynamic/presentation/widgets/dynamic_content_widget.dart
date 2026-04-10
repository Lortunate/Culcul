import 'package:culcul/features/dynamic/domain/entities/dynamic_entities.dart';
import 'package:culcul/features/dynamic/presentation/pages/topic_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_common_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_goods_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_images_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_link_card_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_reserve_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_ugc_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_video_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/content/dynamic_vote_widget.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_forward_widget.dart';
import 'package:culcul/shared/widgets/bilibili_emoji_text.dart';
import 'package:flutter/material.dart';

class DynamicContentWidget extends StatelessWidget {
  final DynamicItem post;
  final bool selectableText;

  const DynamicContentWidget({
    super.key,
    required this.post,
    this.selectableText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contentText = post.contentText;
    final visibility = _resolveVisibility(post);
    final additionalWidget = post.additional == null
        ? null
        : _buildAdditional(post.additional!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (visibility.showText && contentText != null) ...[
          BilibiliEmojiText(
            text: contentText,
            emojiMap: const {},
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, fontSize: 15),
            selectable: selectableText,
          ),
          const SizedBox(height: 8),
        ],
        if (visibility.showImages) DynamicImagesWidget(images: post.images!),
        if (post.videoContent != null) const SizedBox(height: 8),
        if (post.videoContent != null) DynamicVideoWidget(video: post.videoContent!),
        if (visibility.showLinkCard) const SizedBox(height: 8),
        if (visibility.showLinkCard) DynamicLinkCardWidget(card: post.linkCard!),
        if (visibility.showAdditional && additionalWidget != null) ...[
          const SizedBox(height: 8),
          additionalWidget,
        ],
        if (post.orig != null) ...[
          const SizedBox(height: 8),
          DynamicForwardWidget(post: post.orig!),
        ],
        if (post.topicName != null) ...[
          const SizedBox(height: 8),
          _TopicChip(
            topicName: post.topicName!,
            onTap: post.topicId == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TopicDetailPage(
                          topicId: post.topicId!,
                          topicName: post.topicName!,
                        ),
                      ),
                    );
                  },
          ),
        ],
      ],
    );
  }

  ({bool showText, bool showImages, bool showLinkCard, bool showAdditional})
  _resolveVisibility(DynamicItem post) {
    final contentText = post.contentText;
    final hasText = contentText != null && contentText.isNotEmpty;
    final hasImages = post.images != null && post.images!.isNotEmpty;
    final hasVideo = post.videoContent != null;
    final hasLinkCard = post.linkCard != null;
    final showLinkCard =
        hasLinkCard && (post.preferLinkCardDisplay || (!hasImages && !hasVideo));
    final showImages = hasImages && !showLinkCard;
    final showText =
        hasText &&
        !(showLinkCard &&
            ((post.linkCard!.desc != null && contentText == post.linkCard!.desc) ||
                contentText == post.linkCard!.title));
    final showAdditional =
        post.additional != null &&
        !(post.additional!.type == 'ADDITIONAL_TYPE_UGC' && (hasVideo || showLinkCard));

    return (
      showText: showText,
      showImages: showImages,
      showLinkCard: showLinkCard,
      showAdditional: showAdditional,
    );
  }

  Widget? _buildAdditional(DynamicAdditional additional) => switch (additional.type) {
    'ADDITIONAL_TYPE_VOTE' => DynamicVoteWidget(additional: additional),
    'ADDITIONAL_TYPE_GOODS' => DynamicGoodsWidget(additional: additional),
    'ADDITIONAL_TYPE_RESERVE' => DynamicReserveWidget(additional: additional),
    'ADDITIONAL_TYPE_UGC' => DynamicUgcWidget(additional: additional),
    'ADDITIONAL_TYPE_COMMON' => DynamicCommonWidget(additional: additional),
    _ => null,
  };
}

class _TopicChip extends StatelessWidget {
  final String topicName;
  final VoidCallback? onTap;

  const _TopicChip({required this.topicName, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              size: 14,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Text(
              topicName,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
