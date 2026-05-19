import 'package:culcul/ui/widgets/cards/app_card_container.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';

class LiveCardSkeleton extends StatelessWidget {
  const LiveCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCardContainer(
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            AspectRatio(aspectRatio: 16 / 9, child: AppShimmerBox(borderRadius: 12)),
            // Content
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  AppShimmerBox(height: 14, width: double.infinity),
                  SizedBox(height: 6),
                  AppShimmerBox(height: 14, width: 80),
                  SizedBox(height: 10),
                  // User Info
                  Row(
                    children: [
                      AppShimmerBox(width: 20, height: 20, borderRadius: 10),
                      SizedBox(width: 6),
                      Expanded(child: AppShimmerBox(height: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
