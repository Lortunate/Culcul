import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/media_utils.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _previewOverlayAlpha = 0.35;
const double _previewButtonAlpha = 0.45;
const double _previewHintAlpha = 0.28;
const double _previewImageDecodeScale = 2.0;
const int _previewMaxDecodeDimension = 4096;

class AppImagePreview extends ConsumerStatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const AppImagePreview({super.key, required this.imageUrls, this.initialIndex = 0});

  static Future<void> open(
    BuildContext context, {
    required List<String> imageUrls,
    int initialIndex = 0,
  }) async {
    final urls = imageUrls.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (urls.isEmpty) return;

    final normalizedIndex = initialIndex.clamp(0, urls.length - 1);
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => AppImagePreview(imageUrls: urls, initialIndex: normalizedIndex),
      ),
    );
  }

  @override
  ConsumerState<AppImagePreview> createState() => _AppImagePreviewState();
}

class _AppImagePreviewState extends ConsumerState<AppImagePreview> {
  late final ValueNotifier<int> _currentIndex;
  late final ExtendedPageController _pageController;
  late final ValueNotifier<bool> _isSaving;

  @override
  void initState() {
    super.initState();
    _currentIndex = ValueNotifier<int>(widget.initialIndex);
    _pageController = ExtendedPageController(initialPage: widget.initialIndex);
    _isSaving = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    _pageController.dispose();
    _isSaving.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    int? previewDecodeDimension(double logicalPixels) {
      final dimension =
          logicalPixels * mediaQuery.devicePixelRatio * _previewImageDecodeScale;
      if (!dimension.isFinite || dimension <= 0) {
        return null;
      }
      return dimension.round().clamp(1, _previewMaxDecodeDimension);
    }

    final cacheWidth = previewDecodeDimension(mediaQuery.size.width);
    final cacheHeight = previewDecodeDimension(mediaQuery.size.height);
    final t = context.t;

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      body: Stack(
        children: [
          ExtendedImageGesturePageView.builder(
            itemCount: widget.imageUrls.length,
            controller: _pageController,
            onPageChanged: (index) => _currentIndex.value = index,
            itemBuilder: (context, index) {
              final imageUrl = widget.imageUrls[index];
              final url = FormatUtils.formatImageUrl(imageUrl);
              return Hero(
                tag: imageUrl,
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
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (context, currentIndex, _) => Positioned(
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
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    ),
                    Expanded(
                      child: Text(
                        '${currentIndex + 1} / ${widget.imageUrls.length}',
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
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isSaving,
            builder: (context, isSaving, _) => Positioned(
              bottom: mediaQuery.padding.bottom + 16,
              left: 16,
              right: 16,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: _previewButtonAlpha),
                  foregroundColor: colorScheme.onPrimary,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: isSaving
                    ? null
                    : () async {
                        if (_isSaving.value) return;
                        _isSaving.value = true;
                        final url = widget.imageUrls[_currentIndex.value];

                        try {
                          context.showAppFeedback(
                            t.common.saving,
                            duration: const Duration(seconds: 20),
                            hideCurrent: true,
                          );
                          await ref.read(mediaServiceProvider).saveImage(url);
                          if (!context.mounted) return;
                          context.showAppFeedback(
                            t.common.save_success,
                            hideCurrent: true,
                          );
                        } catch (error) {
                          if (!context.mounted) return;
                          final message = error.toString().replaceFirst(
                            'Exception: ',
                            '',
                          );
                          context.showAppFeedback(
                            t.common.save_failed(message: message),
                            level: AppFeedbackLevel.error,
                            hideCurrent: true,
                          );
                        } finally {
                          if (mounted) _isSaving.value = false;
                        }
                      },
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
            ),
          ),
          if (widget.imageUrls.length > 1)
            Positioned(
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
            ),
        ],
      ),
    );
  }
}
