import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final double borderRadius;
  final BoxFit fit;
  final bool cache;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useShimmer;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.cache = true,
    this.placeholder,
    this.errorWidget,
    this.useShimmer = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (url.isEmpty) {
      return _buildErrorWidget(colorScheme);
    }

    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final int? cacheW =
        memCacheWidth ?? (width != null ? (width! * devicePixelRatio).toInt() : null);
    final int? cacheH =
        memCacheHeight ?? (height != null ? (height! * devicePixelRatio).toInt() : null);

    return ExtendedImage.network(
      FormatUtils.formatImageUrl(url),
      headers: const {
        'Referer': ApiConstants.referer,
        'User-Agent': ApiConstants.userAgent,
      },
      width: width,
      height: height,
      cacheWidth: cacheW,
      cacheHeight: cacheH,
      fit: fit,
      cache: cache,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(borderRadius),
      gaplessPlayback: true,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            if (placeholder != null) return placeholder;
            if (useShimmer) {
              return AppShimmer(
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              );
            }
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            );
          case LoadState.failed:
            return _buildErrorWidget(colorScheme);
          case LoadState.completed:
            return null;
        }
      },
    );
  }

  Widget _buildErrorWidget(ColorScheme colorScheme) {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Icon(
            Icons.broken_image_outlined,
            color: colorScheme.outline,
            size: (width != null && width! < 40) ? 16 : 24,
          ),
        );
  }
}
