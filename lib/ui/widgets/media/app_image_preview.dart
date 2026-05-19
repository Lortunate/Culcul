import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'app_image_preview.widgets.dart';

const double _previewOverlayAlpha = 0.35;
const double _previewButtonAlpha = 0.45;
const double _previewHintAlpha = 0.28;

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

  Future<void> _saveImage(String url) async {
    if (_isSaving.value) return;
    _isSaving.value = true;
    final t = context.t;

    try {
      context.showAppFeedback(
        t.common.saving,
        duration: const Duration(seconds: 20),
        hideCurrent: true,
      );
      await ref.read(mediaServiceProvider).saveImage(url);
      if (!mounted) return;
      context.showAppFeedback(t.common.save_success, hideCurrent: true);
    } catch (error) {
      if (!mounted) return;
      final message = error.toString().replaceFirst('Exception: ', '');
      context.showAppFeedback(
        t.common.save_failed(message: message),
        level: AppFeedbackLevel.error,
        hideCurrent: true,
      );
    } finally {
      if (mounted) _isSaving.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final t = context.t;

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      body: Stack(
        children: [
          _PreviewImagePager(
            imageUrls: widget.imageUrls,
            pageController: _pageController,
            colorScheme: colorScheme,
            onPageChanged: (index) => _currentIndex.value = index,
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (context, currentIndex, _) => _PreviewTopBar(
              colorScheme: colorScheme,
              mediaQuery: mediaQuery,
              currentIndex: currentIndex,
              totalCount: widget.imageUrls.length,
              onClose: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isSaving,
            builder: (context, isSaving, _) => _PreviewSaveButton(
              colorScheme: colorScheme,
              mediaQuery: mediaQuery,
              t: t,
              isSaving: isSaving,
              onSave: () => _saveImage(widget.imageUrls[_currentIndex.value]),
            ),
          ),
          if (widget.imageUrls.length > 1)
            _PreviewSwipeHint(colorScheme: colorScheme, mediaQuery: mediaQuery, t: t),
        ],
      ),
    );
  }
}
