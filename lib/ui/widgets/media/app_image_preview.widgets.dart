part of 'app_image_preview.dart';

const double _previewImageDecodeScale = 2.0;
const int _previewMaxDecodeDimension = 4096;

int? _previewDecodeDimension(double logicalPixels, double devicePixelRatio) {
  final dimension = logicalPixels * devicePixelRatio * _previewImageDecodeScale;
  if (!dimension.isFinite || dimension <= 0) {
    return null;
  }
  return dimension.round().clamp(1, _previewMaxDecodeDimension);
}

class _PreviewImagePager extends StatelessWidget {
  final List<String> imageUrls;
  final ExtendedPageController pageController;
  final ColorScheme colorScheme;
  final ValueChanged<int> onPageChanged;

  const _PreviewImagePager({
    required this.imageUrls,
    required this.pageController,
    required this.colorScheme,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cacheWidth = _previewDecodeDimension(
      mediaQuery.size.width,
      mediaQuery.devicePixelRatio,
    );
    final cacheHeight = _previewDecodeDimension(
      mediaQuery.size.height,
      mediaQuery.devicePixelRatio,
    );

    return ExtendedImageGesturePageView.builder(
      itemCount: imageUrls.length,
      controller: pageController,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final url = FormatUtils.formatImageUrl(imageUrls[index]);
        return Hero(
          tag: imageUrls[index],
          child: ExtendedImage.network(
            url,
            fit: BoxFit.contain,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (_) => GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              inPageView: true,
            ),
            loadStateChanged: (state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return Center(
                    child: CircularProgressIndicator(color: colorScheme.onPrimary),
                  );
                case LoadState.completed:
                  return null;
                case LoadState.failed:
                  return Center(
                    child: Icon(Icons.broken_image, color: colorScheme.onPrimary),
                  );
              }
            },
          ),
        );
      },
    );
  }
}

class _PreviewTopBar extends StatelessWidget {
  final ColorScheme colorScheme;
  final MediaQueryData mediaQuery;
  final int currentIndex;
  final int totalCount;
  final VoidCallback onClose;

  const _PreviewTopBar({
    required this.colorScheme,
    required this.mediaQuery,
    required this.currentIndex,
    required this.totalCount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: mediaQuery.padding.top + 8,
      left: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: _previewOverlayAlpha),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.close, color: colorScheme.onPrimary),
              onPressed: onClose,
            ),
            Expanded(
              child: Text(
                '${currentIndex + 1} / $totalCount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

class _PreviewSaveButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final MediaQueryData mediaQuery;
  final Translations t;
  final bool isSaving;
  final VoidCallback onSave;

  const _PreviewSaveButton({
    required this.colorScheme,
    required this.mediaQuery,
    required this.t,
    required this.isSaving,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: mediaQuery.padding.bottom + 16,
      left: 16,
      right: 16,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black.withValues(alpha: _previewButtonAlpha),
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(48),
        ),
        onPressed: isSaving ? null : onSave,
        icon: isSaving
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.onPrimary,
                ),
              )
            : const Icon(Icons.download_rounded),
        label: Text(isSaving ? t.common.saving : t.common.save_image),
      ),
    );
  }
}

class _PreviewSwipeHint extends StatelessWidget {
  final ColorScheme colorScheme;
  final MediaQueryData mediaQuery;
  final Translations t;

  const _PreviewSwipeHint({
    required this.colorScheme,
    required this.mediaQuery,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: mediaQuery.padding.bottom + 76,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: _previewHintAlpha),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            t.common.slide_to_switch,
            style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
