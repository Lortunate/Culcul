import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class DynamicSkeleton extends StatelessWidget {
  const DynamicSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.only(bottom: 8),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const AppShimmerBox(
                  width: 40,
                  height: 40,
                  borderRadius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AppShimmerBox(height: 14, width: 100),
                      SizedBox(height: 6),
                      AppShimmerBox(height: 12, width: 60),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Content
            const AppShimmerBox(height: 14, width: double.infinity),
            const SizedBox(height: 8),
            const AppShimmerBox(height: 14, width: double.infinity),
            const SizedBox(height: 8),
            const AppShimmerBox(height: 14, width: 200),
            const SizedBox(height: 12),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppShimmerBox(height: 20, width: 60),
                AppShimmerBox(height: 20, width: 60),
                AppShimmerBox(height: 20, width: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
