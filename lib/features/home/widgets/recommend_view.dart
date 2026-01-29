import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/data/models/home/index.dart';
import 'package:cilixili/features/home/providers/home_recommend_provider.dart';
import 'package:cilixili/shared/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecommendView extends HookConsumerWidget {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendAsync = ref.watch(homeRecommendProvider);

    return PagingListView<VideoModel>(
      asyncValue: recommendAsync,
      onRefresh: () => ref.read(homeRecommendProvider.notifier).refresh(),
      onLoadMore: () => ref.read(homeRecommendProvider.notifier).loadMore(),
      errorBuilder: (context, err, _) => AppErrorWidget(
        message: err.toString(),
        onRetry: () => ref.read(homeRecommendProvider.notifier).refresh(),
      ),
      loadingBuilder: const _SkeletonGrid(),
      containerBuilder: (context, items) => Column(
        children: [
          const _BannerSection(),
          _VideoGrid(videos: items),
        ],
      ),
      itemBuilder: (context, item, index) => const SizedBox.shrink(),
    );
  }
}

class _BannerSection extends StatelessWidget {
  const _BannerSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: AspectRatio(
        aspectRatio: 2.8,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              color: isDark ? Colors.grey[700] : Colors.grey[400],
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoGrid extends StatelessWidget {
  final List<VideoModel> videos;
  const _VideoGrid({required this.videos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: AlignedGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        itemCount: videos.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final video = videos[index];
          return VideoCard(
            video: video,
            onTap: () => context.push('/video/${video.bvid}'),
          );
        },
      ),
    );
  }
}

class _SkeletonGrid extends StatelessWidget {
  const _SkeletonGrid();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          const _BannerSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: AlignedGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 12,
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (context, index) => const VideoCardSkeleton(),
            ),
          ),
        ],
      ),
    );
  }
}
