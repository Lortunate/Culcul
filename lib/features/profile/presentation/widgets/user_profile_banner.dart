import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileBanner extends StatelessWidget {
  final String? bannerUrl;
  final VoidCallback? onTap;

  const UserProfileBanner({super.key, this.bannerUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (bannerUrl != null && bannerUrl!.isNotEmpty)
            AppNetworkImage(url: bannerUrl!, fit: BoxFit.cover)
          else
            Container(color: theme.colorScheme.surfaceContainerHighest),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.scrim.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
