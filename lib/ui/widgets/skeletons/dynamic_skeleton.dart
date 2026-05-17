import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:flutter/material.dart';

class DynamicSkeleton extends StatelessWidget {
  const DynamicSkeleton({super.key});

  Widget _buildHeader() {
    return const Row(
      children: [
        AppShimmerBox(width: 40, height: 40, borderRadius: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppShimmerBox(height: 14, width: 100),
              SizedBox(height: 6),
              AppShimmerBox(height: 12, width: 60),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmerBox(height: 14, width: double.infinity),
        SizedBox(height: 8),
        AppShimmerBox(height: 14, width: double.infinity),
        SizedBox(height: 8),
        AppShimmerBox(height: 14, width: 200),
      ],
    );
  }

  Widget _buildFooter() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppShimmerBox(height: 20, width: 60),
        AppShimmerBox(height: 20, width: 60),
        AppShimmerBox(height: 20, width: 60),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: AppShimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildContent(),
              const SizedBox(height: 12),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
