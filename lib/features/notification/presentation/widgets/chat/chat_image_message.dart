import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatImageMessage extends StatelessWidget {
  final String url;
  final Color placeholderColor;

  const ChatImageMessage({super.key, required this.url, required this.placeholderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: ExtendedImageGesturePageView.builder(
                itemCount: 1,
                controller: ExtendedPageController(),
                itemBuilder: (BuildContext context, int index) {
                  return ExtendedImage.network(
                    url,
                    fit: BoxFit.contain,
                    cache: true,
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
                  );
                },
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ExtendedImage.network(
          url,
          fit: BoxFit.cover,
          cache: true,
          borderRadius: BorderRadius.circular(8),
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              return Container(
                color: placeholderColor,
                width: 150,
                height: 150,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
