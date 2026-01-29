import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final bool cache;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.cache = true,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget image = ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit,
      cache: cache,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(borderRadius),
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return placeholder ??
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                );
          case LoadState.failed:
            return errorWidget ??
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: isDark ? Colors.grey[600] : Colors.grey[400],
                    size: (width != null && width! < 40) ? 16 : 24,
                  ),
                );
          case LoadState.completed:
            return null;
        }
      },
    );

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    return image;
  }
}
