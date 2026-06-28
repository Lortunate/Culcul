import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/search/application/search_result.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/cards/video_list_card.dart';
import 'package:culcul/ui/widgets/cards/video_list_card_dimensions.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/widgets/media/network_image_prefetch_specs.dart';
import 'package:culcul/ui/widgets/text/icon_text.dart';
import 'package:culcul/ui/widgets/users/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const int _prefetchItemScanLimit = 8;
const int _articleImageScanLimit = 3;
const int _imagePrefetchLimit = 12;

const double _videoCoverLogicalWidth = 160;
const double _videoCoverLogicalHeight = 90;
const double _avatarLogicalSize = 60;
const double _bangumiCoverLogicalWidth = 82.5;
const double _bangumiCoverLogicalHeight = 110;
const double _topicCoverLogicalSize = 80;

class SearchResultList extends HookWidget {
  final List<SearchResultEntry> items;
  final bool hasMore;
  final bool isLoadingMore;
  final Future<void> Function() onLoadMore;
  final ValueChanged<String> onOpenVideo;
  final ValueChanged<int> onOpenUser;
  final void Function(int topicId, String topicName) onOpenTopic;

  const SearchResultList({
    super.key,
    required this.items,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onOpenVideo,
    required this.onOpenUser,
    required this.onOpenTopic,
  });

  @override
  Widget build(BuildContext context) {
    final loadGate = useMemoized(PaginationLoadGate.new, const []);
    useEffect(() {
      loadGate.reset();
      return null;
    }, [onLoadMore]);
    useEffect(() {
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      final specs = <NetworkImagePrefetchSpec>[];

      for (final item in items.take(_prefetchItemScanLimit)) {
        switch (item) {
          case SearchVideoEntry():
            specs.addAll(
              buildNetworkImagePrefetchSpecs(
                [item],
                count: 1,
                logicalWidth: _videoCoverLogicalWidth,
                logicalHeight: _videoCoverLogicalHeight,
                pixelRatio: pixelRatio,
                imageUrl: (item) => item.coverUrl,
              ),
            );
          case SearchUserEntry():
            specs.addAll(
              buildNetworkImagePrefetchSpecs(
                [item],
                count: 1,
                logicalWidth: _avatarLogicalSize,
                logicalHeight: _avatarLogicalSize,
                pixelRatio: pixelRatio,
                imageUrl: (item) => item.avatarUrl,
              ),
            );
          case SearchBangumiEntry():
            specs.addAll(
              buildNetworkImagePrefetchSpecs(
                [item],
                count: 1,
                logicalWidth: _bangumiCoverLogicalWidth,
                logicalHeight: _bangumiCoverLogicalHeight,
                pixelRatio: pixelRatio,
                imageUrl: (item) => item.coverUrl,
              ),
            );
          case SearchArticleEntry():
            specs.addAll(
              buildNetworkImagePrefetchSpecs(
                item.imageUrls.take(_articleImageScanLimit),
                count: _articleImageScanLimit,
                logicalWidth: _videoCoverLogicalWidth,
                logicalHeight: _videoCoverLogicalHeight,
                pixelRatio: pixelRatio,
                imageUrl: (url) => url,
              ),
            );
          case SearchTopicEntry():
            final coverUrl = item.coverUrl;
            if (coverUrl != null && coverUrl.isNotEmpty) {
              specs.addAll(
                buildNetworkImagePrefetchSpecs(
                  [coverUrl],
                  count: 1,
                  logicalWidth: _topicCoverLogicalSize,
                  logicalHeight: _topicCoverLogicalSize,
                  pixelRatio: pixelRatio,
                  imageUrl: (url) => url,
                ),
              );
            }
        }
      }

      AppNetworkImagePrefetcher.prefetch(
        context,
        specs: specs,
        limit: _imagePrefetchLimit,
      );
      return null;
    }, [items]);

    final t = Translations.of(context);

    if (items.isEmpty) {
      return Center(child: AppEmptyStateWidget(message: t.search.status.empty));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) =>
          ScrollLoadTrigger.triggerOnScrollNotificationWithGate(
            notification: notification,
            extentAfterThreshold: 420,
            viewportFactor: 1.35,
            maxThreshold: 960,
            gate: loadGate,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            task: onLoadMore,
            itemCount: () => items.length,
            hasMoreAfter: () => hasMore,
            source: 'search.search_result_list',
            onlyOnScrollEnd: false,
          ),
      child: ListView.separated(
        cacheExtent: 640,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: items.length + (hasMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          }

          final item = items[index];
          switch (item) {
            case final SearchVideoEntry v:
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;

              return VideoListCard(
                flat: true,
                onTap: () {
                  if (v.bvid.isNotEmpty) {
                    onOpenVideo(v.bvid);
                  }
                },
                padding: EdgeInsets.zero,
                coverUrl: v.coverUrl,
                title: FormatUtils.stripHtmlTags(v.title),
                duration: FormatUtils.parseDurationString(v.durationText),
                aspectRatio: wideVideoListCardThumbnailAspectRatio,
                height: wideVideoListCardThumbnailHeight,
                author: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        v.typeName.isEmpty ? t.search.tabs.video : v.typeName,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        v.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                stats: [
                  IconText(
                    icon: Icons.play_circle_outline_rounded,
                    text: FormatUtils.formatAnyNumber(v.playCount ?? v.viewCount),
                  ),
                  IconText(
                    icon: Icons.list_alt_rounded,
                    text: FormatUtils.formatAnyNumber(
                      v.danmakuCount ?? v.videoReviewCount,
                    ),
                  ),
                ],
              );
            case final SearchUserEntry u:
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;

              return UserListTile(
                onTap: () {
                  if (u.mid != 0) {
                    onOpenUser(u.mid);
                  }
                },
                avatarUrl: u.avatarUrl,
                avatarSize: 60,
                name: FormatUtils.stripHtmlTags(u.name),
                subtitle: u.sign != null ? FormatUtils.stripHtmlTags(u.sign!) : null,
                stats: [
                  Row(
                    children: [
                      Text(
                        t.profile.stats.followers,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        FormatUtils.formatAnyNumber(u.fans),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        t.search.tabs.video,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        FormatUtils.formatAnyNumber(u.videos),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              );
            case final SearchBangumiEntry b:
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;

              return VideoListCard(
                height: 110,
                padding: const EdgeInsets.symmetric(vertical: 4),
                coverUrl: '',
                title: FormatUtils.stripHtmlTags(b.title),
                leading: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: AppNetworkImage(
                    url: b.coverUrl,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                middleContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${b.seasonTypeName} · ${b.areas}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      FormatUtils.stripHtmlTags(b.styles),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                author: b.label != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          b.label!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : null,
              );
            case final SearchArticleEntry a:
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;
              final imageCount = a.imageUrls.length;

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FormatUtils.stripHtmlTags(a.title),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (imageCount >= 3)
                        Row(
                          children: [
                            for (int i = 0; i < 3; i++)
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: i < 2 ? 6.0 : 0),
                                  child: AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: AppNetworkImage(
                                      url: a.imageUrls[i],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      else if (imageCount > 0)
                        AspectRatio(
                          aspectRatio: wideVideoListCardThumbnailAspectRatio,
                          child: AppNetworkImage(
                            url: a.imageUrls[0],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 13,
                            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            a.author,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconText(
                            icon: Icons.remove_red_eye_outlined,
                            text: FormatUtils.formatAnyNumber(a.viewCount),
                            iconSize: 12,
                            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                          ),
                          const SizedBox(width: 12),
                          IconText(
                            icon: Icons.chat_bubble_outline_rounded,
                            text: FormatUtils.formatAnyNumber(a.reviewCount),
                            iconSize: 12,
                            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            case final SearchTopicEntry t:
              final theme = Theme.of(context);
              final colorScheme = theme.colorScheme;
              final translations = Translations.of(context);

              return GestureDetector(
                onTap: () {
                  if (t.topicId != 0) {
                    onOpenTopic(t.topicId, FormatUtils.stripHtmlTags(t.title));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (t.coverUrl != null)
                        AppNetworkImage(
                          url: t.coverUrl!,
                          width: 80,
                          height: 80,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FormatUtils.stripHtmlTags(t.title),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (t.description != null)
                              Text(
                                FormatUtils.stripHtmlTags(t.description!),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            const SizedBox(height: 8),
                            if (t.updateCount != null)
                              Text(
                                translations.moments.topic_updates(
                                  count: t.updateCount!.toString(),
                                ),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.primary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
