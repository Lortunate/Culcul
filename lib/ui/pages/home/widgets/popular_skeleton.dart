import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:flutter/material.dart';

class PopularSkeleton extends StatelessWidget {
  const PopularSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: VideoListSkeleton(),
              ),
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}
