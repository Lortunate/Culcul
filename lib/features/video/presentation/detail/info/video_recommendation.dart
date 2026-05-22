import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/ui/assemblies/feed_cards/video_list_card.dart';
import 'package:culcul/ui/widgets/buttons/app_tag.dart';
import 'package:flutter/material.dart';

class RecommendationItem extends StatelessWidget {
  final VideoModel video;
  final ValueChanged<String> onOpenVideo;

  const RecommendationItem({super.key, required this.video, required this.onOpenVideo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return VideoListCard(
      title: video.title,
      coverUrl: video.pic,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      thumbnailWidth: 104,
      height: 66,
      padding: EdgeInsets.zero,
      flat: true,
      badge: video.rcmdReason.isNotEmpty
          ? AppTag(text: video.rcmdReason, fontSize: 11)
          : null,
      author: Text(
        video.owner.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
      onTap: () => onOpenVideo(video.bvid),
    );
  }
}
