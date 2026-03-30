part of '../video_card.dart';

class _VideoCardThumbnail extends StatelessWidget {
  final String coverUrl;
  final int duration;
  final int viewCount;
  final int danmakuCount;
  final String? reason;

  const _VideoCardThumbnail({
    required this.coverUrl,
    required this.duration,
    required this.viewCount,
    required this.danmakuCount,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cacheWidth = (mediaQuery.size.width / 2 * mediaQuery.devicePixelRatio).toInt();

    return Stack(
      children: [
        VideoThumbnail(
          url: coverUrl,
          duration: duration,
          viewCount: viewCount,
          danmakuCount: danmakuCount,
          borderRadius: 0,
          memCacheWidth: cacheWidth,
        ),
        if (reason case final reasonText? when reasonText.isNotEmpty)
          Positioned(top: 8, right: 8, child: AppOverlayTag(text: reasonText)),
      ],
    );
  }
}
