import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  static const double _overlayAlpha = 0.35;
  static const double _buttonAlpha = 0.45;
  static const double _hintAlpha = 0.28;

  late int _currentIndex;
  late final ExtendedPageController _pageController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = ExtendedPageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _saveImage(String url) async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    final messenger = ScaffoldMessenger.of(context);
    final t = i18n(context);

    try {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(t.common.saving),
            duration: const Duration(seconds: 20),
            behavior: SnackBarBehavior.floating,
          ),
        );
      await ref.read(mediaServiceProvider).saveImage(url);
      if (!mounted) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(t.common.save_success),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } catch (error) {
      if (!mounted) return;
      final message = error.toString().replaceFirst('Exception: ', '');
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(t.common.save_failed(message: message)),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final t = i18n(context);

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      body: Stack(
        children: [
          _buildImagePageView(colorScheme),
          _buildTopBar(colorScheme, mediaQuery),
          _buildSaveButton(colorScheme, mediaQuery, t),
          if (widget.imageUrls.length > 1) _buildSwipeHint(colorScheme, mediaQuery, t),
        ],
      ),
    );
  }

  Widget _buildImagePageView(ColorScheme colorScheme) {
    return ExtendedImageGesturePageView.builder(
      itemCount: widget.imageUrls.length,
      controller: _pageController,
      onPageChanged: (index) => setState(() => _currentIndex = index),
      itemBuilder: (context, index) {
        final url = FormatUtils.formatImageUrl(widget.imageUrls[index]);
        return Hero(
          tag: widget.imageUrls[index],
          child: ExtendedImage.network(
            url,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (_) => GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
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

  Widget _buildTopBar(ColorScheme colorScheme, MediaQueryData mediaQuery) {
    return Positioned(
      top: mediaQuery.padding.top + 8,
      left: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: _overlayAlpha),
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
                '${_currentIndex + 1} / ${widget.imageUrls.length}',
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

  Widget _buildSaveButton(
    ColorScheme colorScheme,
    MediaQueryData mediaQuery,
    Translations t,
  ) {
    return Positioned(
      bottom: mediaQuery.padding.bottom + 16,
      left: 16,
      right: 16,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black.withValues(alpha: _buttonAlpha),
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(48),
        ),
        onPressed: _isSaving ? null : () => _saveImage(widget.imageUrls[_currentIndex]),
        icon: _isSaving
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.onPrimary,
                ),
              )
            : const Icon(Icons.download_rounded),
        label: Text(_isSaving ? t.common.saving : t.common.save_image),
      ),
    );
  }

  Widget _buildSwipeHint(
    ColorScheme colorScheme,
    MediaQueryData mediaQuery,
    Translations t,
  ) {
    return Positioned(
      bottom: mediaQuery.padding.bottom + 76,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: _hintAlpha),
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
