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
    final t = context.t;

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
    final t = context.t;

    return Scaffold(
      backgroundColor: colorScheme.scrim,
      body: Stack(
        children: [
          _PreviewImagePager(
            imageUrls: widget.imageUrls,
            pageController: _pageController,
            colorScheme: colorScheme,
            onPageChanged: (index) => setState(() => _currentIndex = index),
          ),
          _PreviewTopBar(
            colorScheme: colorScheme,
            mediaQuery: mediaQuery,
            currentIndex: _currentIndex,
            totalCount: widget.imageUrls.length,
            onClose: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          _PreviewSaveButton(
            colorScheme: colorScheme,
            mediaQuery: mediaQuery,
            t: t,
            isSaving: _isSaving,
            onSave: () => _saveImage(widget.imageUrls[_currentIndex]),
          ),
          if (widget.imageUrls.length > 1)
            _PreviewSwipeHint(colorScheme: colorScheme, mediaQuery: mediaQuery, t: t),
        ],
      ),
    );
  }
}
