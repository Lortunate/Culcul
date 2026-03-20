import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/data/models/extensions/video_mapping.dart';
import 'package:culcul/data/models/index.dart';
import 'package:culcul/ui/widgets/index.dart';
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
