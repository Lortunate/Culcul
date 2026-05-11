import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/ui/widgets/media/app_image_preview.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CommentImagesWidget extends StatelessWidget {
  static const int _maxDecodeDimension = 2048;
  final List<CommentPicture> pictures;

  const CommentImagesWidget({super.key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    if (pictures.isEmpty) return const SizedBox.shrink();

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
    final double? w = picture.imgWidth > 0 ? picture.imgWidth.toDouble() : null;
    final double? h = picture.imgHeight > 0 ? picture.imgHeight.toDouble() : null;

    double aspectRatio = 1.0;
    if (w != null && h != null && h > 0) {
      aspectRatio = w / h;
    }

    const double maxSide = 200.0;
    const double minSide = 100.0;
    final displaySize = _resolveSingleImageDisplaySize(
      aspectRatio: aspectRatio,
      maxSide: maxSide,
      minSide: minSide,
    );
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

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
            child: ExtendedImage.network(
              FormatUtils.formatImageUrl(picture.imgSrc),
              fit: BoxFit.cover,
              cache: true,
              cacheWidth: _toCacheDimension(displaySize.width, devicePixelRatio),
              cacheHeight: _toCacheDimension(displaySize.height, devicePixelRatio),
              borderRadius: BorderRadius.circular(8),
              loadStateChanged: (state) => _buildLoadState(context, state),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        const int crossAxisCount = 3;
        const double spacing = 8.0;
        final double totalWidth = constraints.maxWidth;
        final double itemSize =
            (totalWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
        final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
        final decodeSize = _toCacheDimension(itemSize, devicePixelRatio);

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(pictures.length, (index) {
            return GestureDetector(
              onTap: () => _openPreview(context, imageUrls, index),
              child: Hero(
                tag: pictures[index].imgSrc,
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: ExtendedImage.network(
                    FormatUtils.formatImageUrl(pictures[index].imgSrc),
                    fit: BoxFit.cover,
                    cache: true,
                    cacheWidth: decodeSize,
                    cacheHeight: decodeSize,
                    borderRadius: BorderRadius.circular(8),
                    loadStateChanged: (state) => _buildLoadState(context, state),
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
        return Container(color: Theme.of(context).colorScheme.surfaceContainerHigh);
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
    AppImagePreview.open(context, imageUrls: imageUrls, initialIndex: index);
  }

  Size _resolveSingleImageDisplaySize({
    required double aspectRatio,
    required double maxSide,
    required double minSide,
  }) {
    if (aspectRatio >= 1.0) {
      final height = (maxSide / aspectRatio).clamp(minSide, maxSide);
      return Size(maxSide, height);
    }
    final width = (maxSide * aspectRatio).clamp(minSide, maxSide);
    return Size(width, maxSide);
  }

  int _toCacheDimension(double logicalSize, double devicePixelRatio) {
    final scaled = (logicalSize * devicePixelRatio).round();
    if (scaled <= 0) return 1;
    return scaled > _maxDecodeDimension ? _maxDecodeDimension : scaled;
  }
}
