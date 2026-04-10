import 'package:culcul/shared/widgets/app_card_container.dart';
import 'package:culcul/shared/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class VideoCardSkeleton extends StatelessWidget {
  const VideoCardSkeleton({super.key});

  Widget _buildContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AppShimmerBox(height: 14, width: double.infinity),
            SizedBox(height: 6),
            AppShimmerBox(height: 14, width: 100),
            Spacer(),
            AppShimmerBox(height: 10, width: 60),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AspectRatio(
              aspectRatio: 16 / 10,
              child: AppShimmerBox(borderRadius: 12),
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }
}
