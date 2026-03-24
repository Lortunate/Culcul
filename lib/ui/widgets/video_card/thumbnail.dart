part of '../video_card.dart';

class _VideoCardThumbnail extends StatelessWidget {
  final VideoModel video;
  final String? reason;

  const _VideoCardThumbnail({required this.video, required this.reason});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final cacheWidth = (mediaQuery.size.width / 2 * mediaQuery.devicePixelRatio).toInt();

    return Stack(
      children: [
        VideoThumbnail(
          url: video.pic,
          duration: video.duration,
          viewCount: video.stat.view,
          danmakuCount: video.stat.danmaku,
          borderRadius: 0,
          memCacheWidth: cacheWidth,
        ),
        if (reason case final reasonText? when reasonText.isNotEmpty)
          Positioned(
            top: 8,
            right: 8,
            child: AppTag(
              text: reasonText,
              color: Colors.black.withValues(alpha: 0.5),
              textColor: Colors.white,
              fontSize: 10
            ),
          ),
      ],
    );
  }
}
