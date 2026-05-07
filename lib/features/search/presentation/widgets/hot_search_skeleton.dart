import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';

class HotSearchSkeleton extends StatelessWidget {
  const HotSearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 40,
          crossAxisSpacing: 12,
          mainAxisSpacing: 8,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Row(
            children: [
              AppShimmerBox(width: 24, height: 18, borderRadius: 2),
              SizedBox(width: 4),
              Expanded(
                child: AppShimmerBox(height: 16, width: double.infinity, borderRadius: 2),
              ),
            ],
          );
        },
      ),
    );
  }
}
