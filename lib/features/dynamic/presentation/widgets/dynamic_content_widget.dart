import 'package:culcul/features/dynamic/application/models/dynamic_item_extensions.dart';
import 'package:culcul/features/dynamic/application/models/dynamic_response.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_content_entities.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/text/bilibili_emoji_text.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/media/app_image_preview.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
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
    final images = post.images;
    final videoContent = post.videoContent;
    final linkCard = post.linkCard;
    final additional = post.additional;
    final orig = post.orig;
    final topicName = post.topicName;
    final topicId = post.topicId;
    final visibility = _resolveVisibility(
      contentText: contentText,
      images: images,
      videoContent: videoContent,
      linkCard: linkCard,
      additional: additional,
      preferLinkCardDisplay: post.preferLinkCardDisplay,
    );
    final additionalWidget = additional == null
        ? null
        : _buildAdditional(context, additional);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (visibility.showText && contentText != null) ...[
          BilibiliEmojiText(
            text: contentText,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, fontSize: 15),
            selectable: selectableText,
          ),
          const SizedBox(height: 8),
        ],
        if (visibility.showImages) _DynamicImages(images: images!),
        if (videoContent != null) const SizedBox(height: 8),
        if (videoContent != null) _DynamicVideoCard(video: videoContent),
        if (visibility.showLinkCard) const SizedBox(height: 8),
        if (visibility.showLinkCard) _DynamicLinkCard(card: linkCard!),
        if (visibility.showAdditional && additionalWidget != null) ...[
          const SizedBox(height: 8),
          additionalWidget,
        ],
        if (orig != null) ...[const SizedBox(height: 8), _DynamicForwardCard(post: orig)],
        if (topicName != null) ...[
          const SizedBox(height: 8),
          _TopicChip(
            topicName: topicName,
            onTap: topicId == null
                ? null
                : () {
                    final navigation = DynamicNavigationScope.of(context);
                    navigation.onOpenTopic(topicId, topicName);
                  },
          ),
        ],
      ],
    );
  }

  ({bool showText, bool showImages, bool showLinkCard, bool showAdditional})
  _resolveVisibility({
    required String? contentText,
    required List<String>? images,
    required DynamicVideoContent? videoContent,
    required DynamicLinkCard? linkCard,
    required DynamicAdditional? additional,
    required bool preferLinkCardDisplay,
  }) {
    final hasText = contentText != null && contentText.isNotEmpty;
    final hasImages = images != null && images.isNotEmpty;
    final hasVideo = videoContent != null;
    final hasLinkCard = linkCard != null;
    final showLinkCard =
        hasLinkCard && (preferLinkCardDisplay || (!hasImages && !hasVideo));
    final showImages = hasImages && !showLinkCard;
    final showText =
        hasText &&
        !(showLinkCard &&
            ((linkCard.desc != null && contentText == linkCard.desc) ||
                contentText == linkCard.title));
    final showAdditional =
        additional != null &&
        !(additional.type == 'ADDITIONAL_TYPE_UGC' && (hasVideo || showLinkCard));

    return (
      showText: showText,
      showImages: showImages,
      showLinkCard: showLinkCard,
      showAdditional: showAdditional,
    );
  }

  Widget? _buildAdditional(BuildContext context, DynamicAdditional additional) {
    switch (additional.type) {
      case 'ADDITIONAL_TYPE_VOTE':
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final t = Translations.of(context);
        return _DynamicContentSurface(
          padding: const EdgeInsets.all(12),
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                additional.title ?? t.moments.vote,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t.moments.vote_stats(
                  participants: additional.voteJoinNum.toString(),
                  options: additional.voteChoiceCnt.toString(),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      case 'ADDITIONAL_TYPE_GOODS':
        return _DynamicGoodsCard(additional: additional);
      case 'ADDITIONAL_TYPE_RESERVE':
        return _DynamicReserveCard(additional: additional);
      case 'ADDITIONAL_TYPE_UGC':
        return _DynamicUgcCard(additional: additional);
      case 'ADDITIONAL_TYPE_COMMON':
        return _DynamicCommonCard(additional: additional);
      default:
        return null;
    }
  }
}

class _DynamicContentSurface extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  const _DynamicContentSurface({
    required this.child,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final surfaceColor = colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(color: surfaceColor, borderRadius: borderRadius),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class _DynamicForwardCard extends StatelessWidget {
  final DynamicItem post;

  const _DynamicForwardCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return _DynamicContentSurface(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppClickable(
                haptic: true,
                onTap: () => _openUserProfile(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '@${post.authorName}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (post.description == null || post.description!.isEmpty) ...[
                const Text(' : '),
                Text(t.moments.forward_post, style: const TextStyle(fontSize: 15)),
              ],
            ],
          ),
          const SizedBox(height: 4),
          DynamicContentWidget(post: post),
        ],
      ),
    );
  }

  void _openUserProfile(BuildContext context) {
    DynamicNavigationScope.of(context).onOpenUser(post.authorMid);
  }
}

class _DynamicImages extends StatelessWidget {
  final List<String> images;

  const _DynamicImages({required this.images});

  @override
  Widget build(BuildContext context) {
    final validImages = images
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .take(9)
        .toList();
    if (validImages.isEmpty) {
      return const SizedBox.shrink();
    }

    if (validImages.length == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openImagePreview(context, validImages, 0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 240, maxWidth: 240),
            child: AppNetworkImage(
              url: validImages.first,
              borderRadius: BorderRadius.circular(8),
              width: 240,
              height: 240,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemSize = (constraints.maxWidth - 8) / 3;
          return Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(
              validImages.length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _openImagePreview(context, validImages, index),
                child: _buildImageItem(validImages[index], itemSize),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageItem(String url, [double? size]) {
    return AppNetworkImage(
      url: url,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(6),
    );
  }

  Future<void> _openImagePreview(
    BuildContext context,
    List<String> urls,
    int initialIndex,
  ) async {
    await AppImagePreview.open(context, imageUrls: urls, initialIndex: initialIndex);
  }
}

class _DynamicGoodsCard extends StatelessWidget {
  final DynamicAdditional additional;

  const _DynamicGoodsCard({required this.additional});

  @override
  Widget build(BuildContext context) {
    final goodsItems = additional.goodsItems;
    if (goodsItems == null || goodsItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _DynamicContentSurface(
      padding: const EdgeInsets.only(top: 8),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (additional.headText != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Text(
                additional.headText!,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ...List.generate(goodsItems.length, (i) {
            final item = goodsItems[i];
            return RepaintBoundary(
              child: ListTile(
                onTap: () => DynamicNavigation.open(context, url: item.jumpUrl),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: AppNetworkImage(
                  url: item.cover,
                  width: 50,
                  height: 50,
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
                subtitle: Text(
                  item.price,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _DynamicReserveCard extends StatelessWidget {
  final DynamicAdditional additional;

  const _DynamicReserveCard({required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final jumpUrl = additional.jumpUrl;
    final canOpen = jumpUrl != null && jumpUrl.isNotEmpty;

    return _DynamicContentSurface(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      onTap: canOpen ? () => DynamicNavigation.open(context, url: jumpUrl) : null,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  additional.title ?? t.moments.reserve,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${additional.desc1 ?? ''}  ${additional.desc2 ?? ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: canOpen
                ? () => DynamicNavigation.open(context, url: jumpUrl)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(additional.state == 1 ? t.moments.reserved : t.moments.reserve),
          ),
        ],
      ),
    );
  }
}

class _DynamicVideoCard extends StatelessWidget {
  final DynamicVideoContent video;

  const _DynamicVideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(
        context,
        fallbackBvid: video.bvid,
        fallbackAid: video.aid,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppNetworkImage(
                url: video.cover,
                width: 140,
                height: 88,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.scrim.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    video.duration,
                    style: TextStyle(color: colorScheme.onPrimary, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        video.playCount,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.list_alt, size: 14, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        video.danmakuCount,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DynamicLinkCard extends StatelessWidget {
  final DynamicLinkCard card;

  const _DynamicLinkCard({required this.card});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(context, url: card.url, title: card.title),
      child: Row(
        children: [
          AppNetworkImage(
            url: card.cover,
            width: 88,
            height: 88,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (card.desc != null && card.desc!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      card.desc!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DynamicUgcCard extends StatelessWidget {
  final DynamicAdditional additional;

  const _DynamicUgcCard({required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(context, url: additional.jumpUrl),
      child: Row(
        children: [
          AppNetworkImage(
            url: additional.cover ?? '',
            width: 140,
            height: 88,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    additional.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    additional.desc2 ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DynamicCommonCard extends StatelessWidget {
  final DynamicAdditional additional;

  const _DynamicCommonCard({required this.additional});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _DynamicContentSurface(
      borderRadius: BorderRadius.circular(6),
      onTap: () => DynamicNavigation.open(context, url: additional.jumpUrl),
      child: Row(
        children: [
          AppNetworkImage(
            url: additional.cover ?? '',
            width: 88,
            height: 88,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    additional.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    additional.desc1 ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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
