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
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = colorScheme.onPrimary;

    return Container(
      height: PlayerTheme.topBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: PlayerTheme.horizontalPadding),
      child: Row(
        children: [
          _buildIconButton(
            icon: Icons.arrow_back_rounded,
            color: iconColor,
            onPressed: onClose,
          ),

          if (title != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title!,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          else
            const Spacer(),

          if (onListen != null)
            _buildIconButton(
              icon: Icons.headphones_rounded,
              color: iconColor,
              onPressed: onListen!,
            ),

          _buildIconButton(
            icon: Icons.more_vert_rounded,
            color: iconColor,
            onPressed: onMore,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, color: color),
      iconSize: PlayerTheme.iconSize,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      onPressed: onPressed,
      splashRadius: 20,
    );
  }
}
