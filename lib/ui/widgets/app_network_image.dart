import 'package:culcul/core/constants/api_constants.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/app_shimmer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNetworkImage extends ConsumerWidget {
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

  int? _resolveCacheSize(int? explicit, double? logicalSize, double pixelRatio) {
    if (explicit != null) {
      return explicit;
    }
    if (logicalSize != null) {
      return (logicalSize * pixelRatio).toInt();
    }
    return null;
  }

  BoxDecoration _buildDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(borderRadius),
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

    final rawUrl = FormatUtils.formatImageUrl(url);
    final finalUrl = rawUrl;

    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cacheW = _resolveCacheSize(memCacheWidth, width, devicePixelRatio);
    final cacheH = _resolveCacheSize(memCacheHeight, height, devicePixelRatio);

    return ExtendedImage.network(
      finalUrl,
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
