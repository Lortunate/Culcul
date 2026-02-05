import 'package:culcul/ui/widgets/skeletons/video_card_skeleton.dart';
import 'package:flutter/material.dart';

class RecommendSkeleton extends StatelessWidget {
  const RecommendSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.88,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => const VideoCardSkeleton(),
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}
