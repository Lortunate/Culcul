import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:culcul/ui/widgets/app_image_preview.dart';
import 'package:flutter/material.dart';

class DynamicImagesWidget extends StatelessWidget {
  final List<String> images;

  const DynamicImagesWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final validImages = images
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .take(9)
        .toList();
    if (validImages.isEmpty) return const SizedBox.shrink();

    if (validImages.length == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openImagePreview(context, validImages, 0),
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240, maxWidth: 240),
              child: AppNetworkImage(
                  url: validImages.first,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(8),
                  width: 240,
                  height: 240,
                ),
            ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemSize = (constraints.maxWidth - 8) / 3;
          return Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(
              validImages.length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _openImagePreview(context, validImages, index),
                child: _buildImageItem(validImages[index], itemSize),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageItem(String url, [double? size]) {
    return AppNetworkImage(url: url, fit: BoxFit.cover, width: size, height: size, borderRadius: BorderRadius.circular(6));
  }

  Future<void> _openImagePreview(
    BuildContext context,
    List<String> urls,
    int initialIndex,
  ) async {
    await AppImagePreview.open(context, imageUrls: urls, initialIndex: initialIndex);
  }
}
