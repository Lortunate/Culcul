import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/shared/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';

class VideoCardSkeleton extends StatelessWidget {
  const VideoCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AspectRatio(
              aspectRatio: 16 / 10,
              child: AppShimmerBox(borderRadius: 8),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppShimmerBox(height: 14, width: double.infinity),
                  SizedBox(height: 6),
                  AppShimmerBox(height: 14, width: 140),
                  SizedBox(height: 12),
                  AppShimmerBox(height: 10, width: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
