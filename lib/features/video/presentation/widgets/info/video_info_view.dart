import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/info/uploader_section.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_actions.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_description.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_parts.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_recommendation.dart';
import 'package:culcul/features/video/presentation/widgets/info/video_stats.dart';
import 'package:culcul/shared/widgets/app_error_widget.dart';
import 'package:culcul/shared/widgets/app_network_image_prefetcher.dart';
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
    final loadState = ref.watch(
      provider.select(
        (state) => (
          isInitialLoading: state.videoDetail == null && state.isLoading,
          error: state.videoDetail == null ? state.error : null,
          detail: state.videoDetail,
        ),
      ),
    );
    final notifier = ref.read(videoDetailControllerProvider(bvid).notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    if (loadState.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final detail = loadState.detail;
    if (detail == null) {
      return AppErrorWidget(
        error: loadState.error ?? Exception(t.common.error),
        onRetry: notifier.load,
      );
    }

    final isFollowed = ref.watch(
      provider.select((state) => state.videoDetail?.reqUser?.attention == 1),
    );
    final currentCid = ref.watch(provider.select((state) => state.currentCid));
    final relatedVideos = ref.watch(provider.select((state) => state.relatedVideos));

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

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Uploader Info Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UploaderSection(
                  owner: detail.owner,
                  isFollowed: isFollowed,
                  onToggleFollow: notifier.toggleFollow,
                ),
              ),

              const SizedBox(height: 12),

              // Title & Metadata
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    VideoStatsRow(detail: detail),
                    const SizedBox(height: 8),
                    // Consolidated Description & Tags
                    ExpandableDescriptionAndTags(
                      description: detail.desc,
                      tags: detail.tag,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Video Interactive Actions
              VideoActionsRow(detail: detail),

              const SizedBox(height: 8),

              // Video Parts Selection (if multiple)
              if (detail.pages.length > 1) ...[
                VideoPartsSection(
                  pages: detail.pages,
                  currentCid: currentCid,
                  onPartChanged: (cid) {
                    ref
                        .read(videoDetailControllerProvider(bvid).notifier)
                        .switchPart(cid);
                  },
                ),
                const SizedBox(height: 12),
              ],

              Divider(
                height: 1,
                thickness: 0.5,
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),

              // Related Recommendations Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  t.video.recommend,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
        ),

        // Related Recommendations Grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => RecommendationItem(video: relatedVideos[index]),
              childCount: relatedVideos.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
