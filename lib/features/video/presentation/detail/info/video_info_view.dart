import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/data/dtos/related_video_dto.dart';
import 'package:culcul/features/video/data/dtos/video_detail_dto.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/detail/info/uploader_section.dart';
import 'package:culcul/features/video/presentation/detail/info/video_actions.dart';
import 'package:culcul/features/video/presentation/detail/info/video_description.dart';
import 'package:culcul/features/video/presentation/detail/info/video_parts.dart';
import 'package:culcul/features/video/presentation/detail/info/video_recommendation.dart';
import 'package:culcul/features/video/presentation/detail/info/video_stats.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/media/app_network_image_prefetcher.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoInfoView extends HookConsumerWidget {
  final String bvid;

  const VideoInfoView({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = videoDetailControllerProvider(bvid);
    final state = ref.watch(
      provider.select(
        (state) => (
          isInitialLoading: state.videoDetail == null && state.isLoading,
          error: state.videoDetail == null ? state.error : null,
          detail: state.videoDetail,
          isFollowed: state.videoDetail?.reqUser?.attention == 1,
          currentCid: state.currentCid,
          relatedVideos: state.relatedVideos,
        ),
      ),
    );
    final notifier = ref.read(provider.notifier);
    final t = Translations.of(context);

    if (state.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final detail = state.detail;
    if (detail == null) {
      return AppErrorWidget(
        error: state.error ?? Exception(t.common.error),
        onRetry: notifier.load,
      );
    }

    final isFollowed = state.isFollowed;
    final currentCid = state.currentCid;
    final relatedVideos = state.relatedVideos;
    final isExpanded = useState(false);

    useEffect(() {
      if (relatedVideos.isEmpty) {
        return null;
      }

      final screenWidth = MediaQuery.sizeOf(context).width;
      final containerWidth = screenWidth > AppBreakpoints.pageMaxWidth
          ? AppBreakpoints.pageMaxWidth
          : screenWidth;
      final itemWidth = (containerWidth - 32 - 10) / 2;
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      AppNetworkImagePrefetcher.prefetch(
        context,
        specs: relatedVideos
            .map(
              (video) => NetworkImagePrefetchSpec(
                url: video.pic,
                memCacheWidth: (itemWidth * pixelRatio).round(),
                memCacheHeight: (itemWidth / (16 / 10) * pixelRatio).round(),
              ),
            )
            .toList(growable: false),
        limit: 4,
      );
      return null;
    }, [relatedVideos]);

    return _VideoInfoLoadedContent(
      detail: detail,
      isFollowed: isFollowed,
      currentCid: currentCid,
      relatedVideos: relatedVideos,
      isExpanded: isExpanded,
      onToggleFollow: notifier.toggleFollow,
      onLike: notifier.toggleVideoLike,
      onCoin: notifier.addVideoCoin,
      onPartChanged: notifier.switchPart,
    );
  }
}

class _VideoInfoLoadedContent extends StatelessWidget {
  final VideoDetail detail;
  final bool isFollowed;
  final int currentCid;
  final List<RelatedVideo> relatedVideos;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback onToggleFollow;
  final VoidCallback onLike;
  final VoidCallback onCoin;
  final ValueChanged<int> onPartChanged;

  const _VideoInfoLoadedContent({
    required this.detail,
    required this.isFollowed,
    required this.currentCid,
    required this.relatedVideos,
    required this.isExpanded,
    required this.onToggleFollow,
    required this.onLike,
    required this.onCoin,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            _VideoInfoHeaderSection(
              detail: detail,
              isFollowed: isFollowed,
              isExpanded: isExpanded,
              onToggleFollow: onToggleFollow,
            ),
            _VideoInfoEngagementSection(
              detail: detail,
              currentCid: currentCid,
              hasRecommendations: relatedVideos.isNotEmpty,
              onLike: onLike,
              onCoin: onCoin,
              onPartChanged: onPartChanged,
            ),
          ]),
        ),
        if (relatedVideos.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index.isOdd) {
                  return Divider(
                    height: 16,
                    thickness: 0.5,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.45),
                  );
                }
                return RecommendationItem(video: relatedVideos[index ~/ 2]);
              }, childCount: relatedVideos.length * 2 - 1),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

class _VideoInfoHeaderSection extends StatelessWidget {
  final VideoDetail detail;
  final bool isFollowed;
  final ValueNotifier<bool> isExpanded;
  final VoidCallback onToggleFollow;

  const _VideoInfoHeaderSection({
    required this.detail,
    required this.isFollowed,
    required this.isExpanded,
    required this.onToggleFollow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: UploaderSection(
            owner: detail.owner,
            isFollowed: isFollowed,
            onToggleFollow: onToggleFollow,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppClickable(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    detail.title,
                    maxLines: isExpanded.value ? null : 1,
                    overflow: isExpanded.value ? null : TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.28,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  isExpanded.value
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: VideoStatsRow(detail: detail, showBvid: isExpanded.value),
        ),
        if (isExpanded.value) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ExpandableDescriptionAndTags(
              description: detail.desc,
              tags: detail.tag,
            ),
          ),
        ],
      ],
    );
  }
}

class _VideoInfoEngagementSection extends StatelessWidget {
  final VideoDetail detail;
  final int currentCid;
  final bool hasRecommendations;
  final VoidCallback onLike;
  final VoidCallback onCoin;
  final ValueChanged<int> onPartChanged;

  const _VideoInfoEngagementSection({
    required this.detail,
    required this.currentCid,
    required this.hasRecommendations,
    required this.onLike,
    required this.onCoin,
    required this.onPartChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        VideoActionsRow(detail: detail, onLike: onLike, onCoin: onCoin),
        const SizedBox(height: 8),
        if (detail.pages.length > 1) ...[
          VideoPartsSection(
            pages: detail.pages,
            currentCid: currentCid,
            onPartChanged: onPartChanged,
          ),
          const SizedBox(height: 10),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: VideoCollectionSummary(
            label: t.video.parts,
            title: detail.title,
            pageCount: detail.pages.length,
          ),
        ),
        const SizedBox(height: 14),
        Divider(
          height: 1,
          thickness: 0.5,
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
        if (hasRecommendations)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Text(
              t.video.recommend,
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}

class VideoCollectionSummary extends StatelessWidget {
  final String label;
  final String title;
  final int pageCount;

  const VideoCollectionSummary({
    super.key,
    required this.label,
    required this.title,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final count = pageCount <= 0 ? 1 : pageCount;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.graphic_eq_rounded, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              '$label - $title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '1/$count',
            style: theme.textTheme.labelLarge?.copyWith(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
