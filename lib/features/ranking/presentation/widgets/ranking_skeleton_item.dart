import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class RankingSkeletonItem extends StatelessWidget {
  const RankingSkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SizedBox(
        height: 88,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Thumbnail with Rank Badge
            Stack(
              children: [
                const AppShimmerBox(width: 140, height: 88, borderRadius: 6),
                // Rank Badge Placeholder
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Right: Content
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerBox(height: 14, width: double.infinity, borderRadius: 2),
                      SizedBox(height: 6),
                      AppShimmerBox(height: 14, width: 120, borderRadius: 2),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author
                      Row(
                        children: [
                          AppShimmerBox(width: 16, height: 16, borderRadius: 8),
                          SizedBox(width: 6),
                          AppShimmerBox(height: 12, width: 60, borderRadius: 2),
                        ],
                      ),
                      SizedBox(height: 6),
                      // Stats
                      Row(
                        children: [
                          AppShimmerBox(height: 10, width: 40, borderRadius: 2),
                          SizedBox(width: 12),
                          AppShimmerBox(height: 10, width: 40, borderRadius: 2),
                        ],
                      ),
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
