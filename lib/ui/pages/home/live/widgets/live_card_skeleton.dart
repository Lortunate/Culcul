import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class LiveCardSkeleton extends StatelessWidget {
  const LiveCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover
        const AspectRatio(
          aspectRatio: 16 / 9,
          child: AppShimmerBox(borderRadius: 12), // Matched radius
        ),
        const SizedBox(height: 8),
        // Title line 1
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), // Matched padding
          child: AppShimmerBox(height: 14, width: double.infinity),
        ),
        const SizedBox(height: 6),
        // User Info Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8), // Matched padding
          child: Row(
            children: [
              const AppShimmerBox(
                width: 20, // Matched size
                height: 20,
                borderRadius: 10,
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: AppShimmerBox(height: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
