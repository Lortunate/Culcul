import 'dart:io';

import 'package:flutter/material.dart';

class PublishDynamicImageGrid extends StatelessWidget {
  const PublishDynamicImageGrid({
    required this.images,
    required this.maxImages,
    required this.onAddTap,
    required this.onRemoveAt,
    super.key,
  });

  final List<File> images;
  final int maxImages;
  final VoidCallback onAddTap;
  final ValueChanged<int> onRemoveAt;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final canAddMore = images.length < maxImages;
    final itemCount = images.length + (canAddMore ? 1 : 0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (canAddMore && index == images.length) {
          return _AddImageButton(onTap: onAddTap, colorScheme: colorScheme);
        }

        return _ImageItem(image: images[index], onRemove: () => onRemoveAt(index));
      },
    );
  }
}

class _ImageItem extends StatelessWidget {
  const _ImageItem({required this.image, required this.onRemove});

  final File image;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.scrim.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16, color: colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddImageButton extends StatelessWidget {
  const _AddImageButton({required this.onTap, required this.colorScheme});

  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.add, size: 32, color: colorScheme.onSurfaceVariant),
      ),
    );
  }
}

