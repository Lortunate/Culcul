import 'package:culcul/shared/format_extensions.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  final String url;
  final int duration;
  final int? viewCount;
  final int? danmakuCount;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final double borderRadius;
  final double aspectRatio;

  const VideoThumbnail({
    super.key,
    required this.url,
    required this.duration,
    this.viewCount,
    this.danmakuCount,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
    this.borderRadius = 8,
    this.aspectRatio = 16 / 10,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(
                url: url,
                width: width,
                height: height,
                memCacheWidth:
                    memCacheWidth ??
                    (constraints.maxWidth.isFinite
                        ? (constraints.maxWidth * MediaQuery.of(context).devicePixelRatio)
                              .toInt()
                        : null),
                memCacheHeight:
                    memCacheHeight ??
                    (constraints.maxHeight.isFinite
                        ? (constraints.maxHeight *
                                  MediaQuery.of(context).devicePixelRatio)
                              .toInt()
                        : null),
                borderRadius: borderRadius,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 48,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(borderRadius),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
                    ),
                  ),
                ),
              ),
              if (viewCount != null || danmakuCount != null)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: VideoThumbnailStats(
                    viewCount: viewCount,
                    danmakuCount: danmakuCount,
                  ),
                ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Text(
                  duration.formatDuration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class VideoThumbnailStats extends StatelessWidget {
  final int? viewCount;
  final int? danmakuCount;

  const VideoThumbnailStats({super.key, this.viewCount, this.danmakuCount});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewCount != null) ...[
          const Icon(Icons.play_circle_outline_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 3),
          Text(viewCount!.formatNumber, style: style),
        ],
        if (danmakuCount != null) ...[
          if (viewCount != null) const SizedBox(width: 8),
          const Icon(Icons.list_alt_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 3),
          Text(danmakuCount!.formatNumber, style: style),
        ],
      ],
    );
  }
}
