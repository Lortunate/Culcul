import 'package:culcul/core/utils/format_extensions.dart';
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
                        _ThumbnailStatItem(
                          icon: Icons.play_circle_outline_rounded,
                          text: viewCount!.formatNumber,
                          textStyle: overlayTextStyle,
                        ),
                      if (danmakuCount != null) ...[
                        if (viewCount != null) const SizedBox(width: 8),
                        _ThumbnailStatItem(
                          icon: Icons.list_alt_rounded,
                          text: danmakuCount!.formatNumber,
                          textStyle: overlayTextStyle,
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

class _ThumbnailStatItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? textStyle;

  const _ThumbnailStatItem({
    required this.icon,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Theme.of(context).colorScheme.onPrimary),
        const SizedBox(width: 3),
        Text(text, style: textStyle),
      ],
    );
  }
}
