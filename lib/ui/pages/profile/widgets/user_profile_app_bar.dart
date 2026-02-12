import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfileAppBar extends StatelessWidget {
  final UserProfile? profile;
  final bool isSliver;

  const UserProfileAppBar({
    super.key,
    this.profile,
    this.isSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use a default banner if profile doesn't have one (currently model doesn't have it)
    // In a real app, we would use profile?.bannerUrl
    const String? bannerUrl = null; 

    final flexibleSpace = FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          if (bannerUrl != null)
            AppNetworkImage(
              url: bannerUrl,
              fit: BoxFit.cover,
            )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.3),
                    colorScheme.surface,
                  ],
                ),
              ),
            ),
            
          // Gradient overlay for text readability if we had an image
          if (bannerUrl != null)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4],
                ),
              ),
            ),
        ],
      ),
      stretchModes: const [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ],
    );

    if (isSliver) {
      return SliverAppBar(
        expandedHeight: 140,
        pinned: true,
        stretch: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: colorScheme.surface,
        leading: const BackButton(color: Colors.white), // Always white on banner
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
        flexibleSpace: flexibleSpace,
      );
    }

    return AppBar(
      // Non-sliver version if needed
      title: Text(profile?.username ?? ''),
    );
  }
}
