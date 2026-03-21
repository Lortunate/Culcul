import 'package:culcul/core/utils/format_extensions.dart';
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
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          int? calcCacheSize(int? explicitSize, double constraintSize) {
            if (explicitSize != null) return explicitSize;
            if (constraintSize.isFinite) {
              return (constraintSize * pixelRatio).toInt();
            }
            return null;
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(
                url: url,
                width: width,
                height: height,
                memCacheWidth: calcCacheSize(memCacheWidth, constraints.maxWidth),
                memCacheHeight: calcCacheSize(memCacheHeight, constraints.maxHeight),
                borderRadius: borderRadius,
                fit: BoxFit.cover,
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 48,
                child: DecoratedBox(
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
                  child: _VideoThumbnailStats(
                    viewCount: viewCount,
                    danmakuCount: danmakuCount,
                    textStyle: textStyle,
                  ),
                ),

              Positioned(
                right: 8,
                bottom: 8,
                child: Text(duration.formatDuration, style: textStyle),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _VideoThumbnailStats extends StatelessWidget {
  final int? viewCount;
  final int? danmakuCount;
  final TextStyle textStyle;

  const _VideoThumbnailStats({
    this.viewCount,
    this.danmakuCount,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewCount != null) ...[
          const Icon(Icons.play_circle_outline_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 3),
          Text(viewCount!.formatNumber, style: textStyle),
        ],
        if (danmakuCount != null) ...[
          if (viewCount != null) const SizedBox(width: 8),
          const Icon(Icons.list_alt_rounded, size: 12, color: Colors.white),
          const SizedBox(width: 3),
          Text(danmakuCount!.formatNumber, style: textStyle),
        ],
      ],
    );
  }
}
