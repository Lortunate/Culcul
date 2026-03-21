import 'package:culcul/core/services/media_service.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImagePreviewPage extends ConsumerStatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImagePreviewPage({super.key, required this.imageUrls, this.initialIndex = 0});

  @override
  ConsumerState<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends ConsumerState<ImagePreviewPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Future<void> _saveImage(String url) async {
    try {
      // Show loading
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('正在保存...')));
      }

      await ref.read(mediaServiceProvider).saveImage(url);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('保存成功')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('保存失败: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ExtendedImageGesturePageView.builder(
            itemCount: widget.imageUrls.length,
            controller: ExtendedPageController(initialPage: widget.initialIndex),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final url = FormatUtils.formatImageUrl(widget.imageUrls[index]);
              return Hero(
                tag: widget.imageUrls[index], // Use original URL as tag
                child: ExtendedImage.network(
                  url,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      inPageView: true,
                    );
                  },
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      case LoadState.completed:
                        return null; // default
                      case LoadState.failed:
                        return const Center(
                          child: Icon(Icons.broken_image, color: Colors.white),
                        );
                    }
                  },
                ),
              );
            },
          ),
          // App Bar / Top controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Page Indicator
          Positioned(
            top: MediaQuery.of(context).padding.top + 24,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${widget.imageUrls.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Bottom Actions
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.download_rounded, color: Colors.white, size: 28),
              onPressed: () => _saveImage(widget.imageUrls[_currentIndex]),
            ),
          ),
        ],
      ),
    );
  }
}
