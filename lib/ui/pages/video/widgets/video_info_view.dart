import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/providers/video/video_detail_state.dart';
import 'package:culcul/ui/pages/video/widgets/video_detail_widgets.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class VideoInfoView extends StatelessWidget {
  final VideoDetailState state;
  final VideoDetailController notifier;

  const VideoInfoView({super.key, required this.state, required this.notifier});

  @override
  Widget build(BuildContext context) {
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

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
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
              ExpandableDescriptionAndTags(description: d.desc, tags: d.tag),
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

        // Related Recommendations
        RecommendationsSection(videos: state.relatedVideos),
      ],
    );
  }
}
