import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppNetworkImage extends ConsumerWidget {
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

  int? _resolveCacheSize(int? explicit, double? logicalSize, double pixelRatio) {
    final explicitSize = _normalizeCacheSize(explicit);
    if (explicitSize != null) {
      return explicitSize;
    }
    if (logicalSize != null) {
      return _normalizeCacheSize((logicalSize * pixelRatio).round());
    }
    return null;
  }

  static int? _normalizeCacheSize(int? rawSize) {
    if (rawSize == null || rawSize <= 0) {
      return null;
    }
    return rawSize.clamp(1, _maxCacheDimension);
  }

  BoxDecoration _buildDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: borderRadius,
    );
  }

  Widget _buildLoadingPlaceholder(ColorScheme colorScheme) {
    final placeholderChild = Container(
      width: width,
      height: height,
      decoration: _buildDecoration(colorScheme),
    );

    if (!useShimmer) {
      return placeholderChild;
    }

    return AppShimmer(child: placeholderChild);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (url.isEmpty) {
      return _buildErrorWidget(colorScheme);
    }

    final finalUrl = resolveUrl(url);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final cacheW = _resolveCacheSize(memCacheWidth, width, devicePixelRatio);
    final cacheH = _resolveCacheSize(memCacheHeight, height, devicePixelRatio);

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
            return _buildLoadingPlaceholder(colorScheme);
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
          decoration: _buildDecoration(colorScheme),
          child: Icon(
            Icons.broken_image_outlined,
            color: colorScheme.outline,
            size: (width != null && width! < 40) ? 16 : 24,
          ),
        );
  }
}
