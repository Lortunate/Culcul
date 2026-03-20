import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/widgets/info/uploader_section.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_actions.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_description.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_parts.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_recommendation.dart';
import 'package:culcul/ui/pages/video/widgets/info/video_stats.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoInfoView extends ConsumerWidget {
  final String bvid;

  const VideoInfoView({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final notifier = ref.read(videoDetailControllerProvider(bvid).notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    if (state.videoDetail == null && state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.videoDetail == null) {
      return Center(child: Text(t.common.error));
    }

    final d = state.videoDetail!;

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
                  owner: d.owner,
                  isFollowed: d.reqUser?.attention == 1,
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
                      d.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    VideoStatsRow(detail: d),
                    const SizedBox(height: 8),
                    // Consolidated Description & Tags
                    ExpandableDescriptionAndTags(
                      description: d.desc,
                      tags: d.tag,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Video Interactive Actions
              VideoActionsRow(state: state, notifier: notifier),

              const SizedBox(height: 8),

              // Video Parts Selection (if multiple)
              if (d.pages.length > 1) ...[
                VideoPartsSection(
                  pages: d.pages,
                  currentCid: state.currentCid,
                  onPartChanged: (cid) => notifier.switchPart(cid),
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
              (context, index) =>
                  RecommendationItem(video: state.relatedVideos[index]),
              childCount: state.relatedVideos.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
