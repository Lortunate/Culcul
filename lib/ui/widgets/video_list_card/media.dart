part of '../video_list_card.dart';

class _VideoListCardMedia extends StatelessWidget {
  final Widget? leading;
  final String coverUrl;
  final int? duration;
  final Widget? overlay;
  final double thumbnailWidth;
  final double aspectRatio;

  const _VideoListCardMedia({
    required this.leading,
    required this.coverUrl,
    required this.duration,
    required this.overlay,
    required this.thumbnailWidth,
    required this.aspectRatio,
  });

  List<Widget>? get _overlayChildren => overlay == null ? null : [overlay!];

  @override
  Widget build(BuildContext context) {
    if (leading != null) {
      return leading!;
    }

    return SizedBox(
      width: thumbnailWidth,
      child: Stack(
        children: [
          VideoThumbnail(
            url: coverUrl,
            duration: duration ?? 0,
            viewCount: null,
            danmakuCount: null,
            borderRadius: 8,
            aspectRatio: aspectRatio,
            width: thumbnailWidth,
            height: thumbnailWidth / aspectRatio,
          ),
          ...?_overlayChildren,
        ],
      ),
    );
  }
}

