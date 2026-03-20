import 'package:culcul/ui/widgets/app_card_container.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class LiveCardSkeleton extends StatelessWidget {
  const LiveCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            const AspectRatio(
              aspectRatio: 16 / 9,
              child: AppShimmerBox(borderRadius: 12),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const AppShimmerBox(height: 14, width: double.infinity),
                  const SizedBox(height: 6),
                  const AppShimmerBox(height: 14, width: 80),
                  const SizedBox(height: 10),
                  // User Info
                  Row(
                    children: const [
                      AppShimmerBox(
                        width: 20,
                        height: 20,
                        borderRadius: 10,
                      ),
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
