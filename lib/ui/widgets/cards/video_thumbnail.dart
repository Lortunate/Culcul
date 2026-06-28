import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final overlayTextStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: colorScheme.onPrimary,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final resolvedMemCacheWidth =
              memCacheWidth ??
              (constraints.maxWidth.isFinite
                  ? (constraints.maxWidth * pixelRatio).toInt()
                  : null);
          final resolvedMemCacheHeight =
              memCacheHeight ??
              (constraints.maxHeight.isFinite
                  ? (constraints.maxHeight * pixelRatio).toInt()
                  : null);

          return Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(
                url: url,
                width: width,
                height: height,
                memCacheWidth: resolvedMemCacheWidth,
                memCacheHeight: resolvedMemCacheHeight,
                borderRadius: BorderRadius.circular(borderRadius),
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
                      colors: [
                        Colors.transparent,
                        colorScheme.scrim.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                ),
              ),
              if (viewCount != null || danmakuCount != null)
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (viewCount != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_circle_outline_rounded,
                              size: 12,
                              color: colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 3),
                            Text(viewCount!.formatNumber, style: overlayTextStyle),
                          ],
                        ),
                      if (danmakuCount != null) ...[
                        if (viewCount != null) const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              size: 12,
                              color: colorScheme.onPrimary,
                            ),
                            const SizedBox(width: 3),
                            Text(danmakuCount!.formatNumber, style: overlayTextStyle),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Text(duration.formatDuration, style: overlayTextStyle),
              ),
            ],
          );
        },
      ),
    );
  }
}
