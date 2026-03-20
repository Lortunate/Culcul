import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:flutter/material.dart';

class PlayerTopBar extends StatelessWidget {
  final String? title;
  final VoidCallback onClose;
  final VoidCallback onMore;
  final VoidCallback? onListen;

  const PlayerTopBar({
    super.key,
    this.title,
    required this.onClose,
    required this.onMore,
    this.onListen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PlayerTheme.topBarHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: PlayerTheme.horizontalPadding,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            iconSize: PlayerTheme.iconSize,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: onClose,
            splashRadius: 20,
          ),
          if (onListen != null)
            IconButton(
              icon: const Icon(Icons.headphones_rounded, color: Colors.white),
              iconSize: PlayerTheme.iconSize,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              onPressed: onListen,
              splashRadius: 20,
            ),
          if (title != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          if (title == null) const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            iconSize: PlayerTheme.iconSize,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: onMore,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
