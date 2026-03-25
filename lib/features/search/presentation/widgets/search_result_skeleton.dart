import 'package:culcul/ui/widgets/skeletons/video_list_skeleton.dart';
import 'package:flutter/material.dart';

class SearchResultSkeleton extends StatelessWidget {
  const SearchResultSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: 10,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return const VideoListSkeleton(
          padding: EdgeInsets.zero,
          height: 100,
          thumbnailWidth: 177,
          aspectRatio: 16 / 9,
        );
      },
    );
  }
}

