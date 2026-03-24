part of '../video_card.dart';

class _VideoCardThumbnail extends StatelessWidget {
  final VideoModel video;

  const _VideoCardThumbnail({required this.video});

  @override
  Widget build(BuildContext context) {
    final cacheWidth =
        (MediaQuery.sizeOf(context).width /
                2 *
                MediaQuery.devicePixelRatioOf(context))
            .toInt();

    return VideoThumbnail(
      url: video.pic,
      duration: video.duration,
      viewCount: video.stat.view,
      danmakuCount: video.stat.danmaku,
      borderRadius: 0,
      memCacheWidth: cacheWidth,
    );
  }
}
