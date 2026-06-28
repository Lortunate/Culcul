import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';

class VideoCardSkeleton extends StatelessWidget {
  const VideoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCardContainer(
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(aspectRatio: 16 / 10, child: AppShimmerBox(borderRadius: 12)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(height: 14, width: double.infinity),
                    SizedBox(height: 6),
                    AppShimmerBox(height: 14, width: 100),
                    Spacer(),
                    AppShimmerBox(height: 10, width: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
