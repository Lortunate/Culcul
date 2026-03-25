import 'package:culcul/features/video/presentation/widgets/controls/player_controls_overlay.dart';
import 'package:flutter/material.dart';

class ControlsLayer extends StatelessWidget {
  final String bvid;
  final VoidCallback onToggleFullscreen;
  final bool isFullscreen;

  const ControlsLayer({
    super.key,
    required this.bvid,
    required this.onToggleFullscreen,
    required this.isFullscreen,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: PlayerControlsOverlay(
        bvid: bvid,
        onToggleFullscreen: onToggleFullscreen,
        onClose: () {
          if (isFullscreen) {
            onToggleFullscreen();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

