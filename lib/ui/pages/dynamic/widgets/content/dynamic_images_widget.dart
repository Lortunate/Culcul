import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class DynamicImagesWidget extends StatelessWidget {
  final List<String> images;

  const DynamicImagesWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 240, maxWidth: 240),
            child: AppNetworkImage(url: images.first, fit: BoxFit.cover),
          ),
        ),
      );
    }

    final size = (MediaQuery.of(context).size.width - 32 - 8) / 3;

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AppNetworkImage(
              url: images[index],
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
          );
        },
      ),
    );
  }
}
