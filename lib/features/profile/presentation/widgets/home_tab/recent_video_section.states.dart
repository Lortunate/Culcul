part of 'recent_video_section.dart';

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Center(child: Text(Translations.of(context).common.no_content)),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.error,
    required this.stackTrace,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppErrorWidget(error: error, stackTrace: stackTrace, onRetry: onRetry),
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  final double spacing;
  final int crossAxisCount;
  final double aspectRatio;

  const _LoadingGrid({
    required this.spacing,
    required this.crossAxisCount,
    required this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: spacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: aspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => const VideoCardSkeleton(),
          childCount: 4,
        ),
      ),
    );
  }
}
