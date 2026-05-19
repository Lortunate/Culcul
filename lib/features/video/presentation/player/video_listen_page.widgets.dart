part of 'video_listen_page.dart';

class _Background extends StatelessWidget {
  final String imageUrl;

  const _Background({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final overlayColor = context.semanticColors.overlayBackground;

    return Stack(
      fit: StackFit.expand,
      children: [
        AppNetworkImage(url: imageUrl),
        RepaintBoundary(
          child: IgnorePointer(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: AppNetworkImage(url: imageUrl, useShimmer: false),
            ),
          ),
        ),
        ColoredBox(color: overlayColor),
      ],
    );
  }
}

class _CoverArt extends StatelessWidget {
  final String imageUrl;

  const _CoverArt({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: colorScheme.onPrimary.withValues(alpha: 0.12),
          width: 4,
        ),
      ),
      child: ClipOval(child: AppNetworkImage(url: imageUrl)),
    );
  }
}

class _TrackInfo extends StatelessWidget {
  final String title;
  final String author;

  const _TrackInfo({required this.title, required this.author});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          author,
          style: TextStyle(
            color: colorScheme.onPrimary.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
