import 'package:culcul/features/video/domain/entities/video_models.dart';
import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/ui/widgets/video_card.dart';
import 'package:flutter/material.dart';

class RecommendationItem extends StatelessWidget {
  final RelatedVideo video;

  const RecommendationItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return VideoCard(
      video: video.toVideoModel(),
      onTap: () => VideoDetailRoute(bvid: video.bvid).push(context),
    );
  }
}
