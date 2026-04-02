import 'package:culcul/features/video/presentation/widgets/controls/player_controls_overlay.dart';
import 'package:culcul/features/video/presentation/pages/video_listen_page.dart';
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
    void openListenPage() {
      if (isFullscreen) {
        onToggleFullscreen();
      }
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => VideoListenPage(bvid: bvid)));
    }

    return Positioned.fill(
      child: PlayerControlsOverlay(
        bvid: bvid,
        onToggleFullscreen: onToggleFullscreen,
        onListen: openListenPage,
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
