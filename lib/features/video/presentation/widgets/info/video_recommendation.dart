import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/shared/widgets/video_card.dart';
import 'package:flutter/material.dart';

class RecommendationItem extends StatelessWidget {
  final RelatedVideo video;

  const RecommendationItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return VideoCard(
      bvid: video.bvid,
      title: video.title,
      coverUrl: video.pic,
      author: video.owner.name,
      description: video.desc,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      reason: video.rcmdReason,
      onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
    );
  }
}
