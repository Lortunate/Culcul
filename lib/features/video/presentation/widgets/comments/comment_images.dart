import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/presentation/widgets/image_preview_page.dart';
import 'package:culcul/data/models/index.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CommentImagesWidget extends StatelessWidget {
  final List<CommentPicture> pictures;

  const CommentImagesWidget({super.key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    if (pictures.isEmpty) return const SizedBox.shrink();

    // Extract URLs for preview
    final imageUrls = pictures.map((p) => p.imgSrc).toList();

    if (pictures.length == 1) {
      return _buildSingleImage(context, pictures.first, imageUrls);
    }

    return _buildImageGrid(context, pictures, imageUrls);
  }

  Widget _buildSingleImage(
    BuildContext context,
    CommentPicture picture,
    List<String> imageUrls,
  ) {
    // Single image logic
    // Limit max size to avoid taking too much space
    // Aspect ratio can be respected but with limits
    final double? w = picture.imgWidth > 0
        ? picture.imgWidth.toDouble()
        : null;
    final double? h = picture.imgHeight > 0
        ? picture.imgHeight.toDouble()
        : null;

    // Calculate aspect ratio
    double aspectRatio = 1.0;
    if (w != null && h != null && h > 0) {
      aspectRatio = w / h;
    }

    // Constraints
    const double maxSide = 200.0;
    const double minSide = 100.0;

    // Simple constrained box approach
    return GestureDetector(
      onTap: () => _openPreview(context, imageUrls, 0),
      child: Hero(
        tag: picture.imgSrc,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: maxSide,
            maxHeight: maxSide,
            minWidth: minSide,
            minHeight: minSide,
          ),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedImage.network(
                FormatUtils.formatImageUrl(picture.imgSrc),
                fit: BoxFit.cover,
                cache: true,
                loadStateChanged: (state) => _buildLoadState(context, state),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid(
    BuildContext context,
    List<CommentPicture> pictures,
    List<String> imageUrls,
  ) {
    // 3 columns grid
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate item size
        // spacing = 8
        const int crossAxisCount = 3;
        const double spacing = 8.0;
        final double totalWidth = constraints.maxWidth;
        final double itemSize =
            (totalWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        // We might want to cap the item size if it's too big (e.g. on tablet)
        // But usually in comments column it's fine.

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(pictures.length, (index) {
            return GestureDetector(
              onTap: () => _openPreview(context, imageUrls, index),
              child: Hero(
                tag: pictures[index].imgSrc,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: itemSize,
                    height: itemSize,
                    child: ExtendedImage.network(
                      FormatUtils.formatImageUrl(pictures[index].imgSrc),
                      fit: BoxFit.cover,
                      cache: true,
                      loadStateChanged: (state) =>
                          _buildLoadState(context, state),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget? _buildLoadState(BuildContext context, ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Container(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        );
      case LoadState.completed:
        return null;
      case LoadState.failed:
        return Container(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: const Icon(Icons.broken_image, size: 20),
        );
    }
  }

  void _openPreview(BuildContext context, List<String> imageUrls, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ImagePreviewPage(imageUrls: imageUrls, initialIndex: index),
      ),
    );
  }
}
