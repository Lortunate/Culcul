import 'package:culcul/ui/widgets/app_image_preview.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatImageMessage extends StatelessWidget {
  final String url;
  final Color placeholderColor;

  const ChatImageMessage({super.key, required this.url, required this.placeholderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppImagePreview.open(context, imageUrls: [url]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ExtendedImage.network(
          url,
          fit: BoxFit.cover,
          cache: true,
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
      ),
    );
  }
}

