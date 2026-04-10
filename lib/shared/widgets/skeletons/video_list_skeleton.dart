import 'package:culcul/shared/widgets/app_card_container.dart';
import 'package:culcul/shared/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class VideoListSkeleton extends StatelessWidget {
  final double thumbnailWidth;
  final double aspectRatio;
  final double height;
  final EdgeInsetsGeometry padding;

  const VideoListSkeleton({
    super.key,
    this.thumbnailWidth = 160,
    this.aspectRatio = 16 / 10,
    this.height = 100,
    this.padding = const EdgeInsets.all(12),
  });

  Widget _buildThumbnail() {
    return SizedBox(
      width: thumbnailWidth,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: const AppShimmerBox(borderRadius: 8),
      ),
    );
  }

  Widget _buildContent() {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmerBox(height: 14, width: double.infinity),
          SizedBox(height: 6),
          AppShimmerBox(height: 14, width: 150),
          SizedBox(height: 12),
          AppShimmerBox(height: 12, width: 100),
          Spacer(),
          Row(
            children: [
              AppShimmerBox(height: 10, width: 60),
              SizedBox(width: 12),
              AppShimmerBox(height: 10, width: 60),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      child: AppShimmer(
        child: Padding(
          padding: padding,
          child: SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildThumbnail(), const SizedBox(width: 12), _buildContent()],
            ),
          ),
        ),
      ),
    );
  }
}
