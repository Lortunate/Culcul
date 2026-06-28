import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/feedback/app_shimmer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  static const int _maxCacheDimension = 2048;
  static const Map<String, String> _defaultHeaders = <String, String>{
    'Referer': ApiConstants.referer,
    'User-Agent': ApiConstants.userAgent,
  };

  final String url;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final BorderRadius? borderRadius;
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
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.cache = true,
    this.placeholder,
    this.errorWidget,
    this.useShimmer = true,
  });

  static String resolveUrl(String url) {
    return FormatUtils.formatImageUrl(url);
  }

  static ImageProvider<Object> providerFor({
    required String url,
    int? memCacheWidth,
    int? memCacheHeight,
    bool cache = true,
  }) {
    final resolvedWidth = _normalizeCacheSize(memCacheWidth);
    final resolvedHeight = _normalizeCacheSize(memCacheHeight);
    return ExtendedResizeImage.resizeIfNeeded(
      provider: ExtendedNetworkImageProvider(
        resolveUrl(url),
        headers: _defaultHeaders,
        cache: cache,
      ),
      cacheWidth: resolvedWidth,
      cacheHeight: resolvedHeight,
    );
  }

  static int? _normalizeCacheSize(int? rawSize) {
    if (rawSize == null || rawSize <= 0) {
      return null;
    }
    return rawSize.clamp(1, _maxCacheDimension);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    late final Widget fallbackErrorWidget =
        errorWidget ??
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: borderRadius,
          ),
          child: Icon(
            Icons.broken_image_outlined,
            color: colorScheme.outline,
            size: (width != null && width! < 40) ? 16 : 24,
          ),
        );

    if (url.isEmpty) {
      return fallbackErrorWidget;
    }

    final finalUrl = resolveUrl(url);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final explicitCacheWidth = _normalizeCacheSize(memCacheWidth);
    final cacheW =
        explicitCacheWidth ??
        (width != null ? _normalizeCacheSize((width! * devicePixelRatio).round()) : null);
    final explicitCacheHeight = _normalizeCacheSize(memCacheHeight);
    final cacheH =
        explicitCacheHeight ??
        (height != null
            ? _normalizeCacheSize((height! * devicePixelRatio).round())
            : null);

    return ExtendedImage.network(
      finalUrl,
      headers: _defaultHeaders,
      width: width,
      height: height,
      cacheWidth: cacheW,
      cacheHeight: cacheH,
      fit: fit,
      cache: cache,
      shape: BoxShape.rectangle,
      borderRadius: borderRadius,
      gaplessPlayback: true,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            if (placeholder != null) return placeholder;
            final placeholderChild = Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: borderRadius,
              ),
            );
            if (!useShimmer) return placeholderChild;
            return AppShimmer(child: placeholderChild);
          case LoadState.failed:
            return fallbackErrorWidget;
          case LoadState.completed:
            return null;
        }
      },
    );
  }
}
