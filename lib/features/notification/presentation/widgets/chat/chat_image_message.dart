import 'package:culcul/ui/widgets/media/app_image_preview.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatImageMessage extends StatelessWidget {
  static const double _maxLogicalSize = 300;
  static const int _maxCacheDimension = 2048;

  final String url;
  final Color placeholderColor;

  const ChatImageMessage({super.key, required this.url, required this.placeholderColor});

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final cacheSize = (_maxLogicalSize * pixelRatio).round().clamp(1, _maxCacheDimension);

    return GestureDetector(
      onTap: () => AppImagePreview.open(context, imageUrls: [url]),
      child: ExtendedImage.network(
        url,
        fit: BoxFit.cover,
        cacheWidth: cacheSize,
        cacheHeight: cacheSize,
        borderRadius: BorderRadius.circular(8),
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.loading) {
            return Container(
              color: placeholderColor,
              width: 150,
              height: 150,
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }
          return null;
        },
      ),
    );
  }
}
