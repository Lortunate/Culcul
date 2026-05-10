import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:flutter/material.dart';

class SpeedIndicator extends StatelessWidget {
  const SpeedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final t = i18n(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: VideoOverlayStyles.panelBackground(colorScheme).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fast_forward_rounded,
                color: VideoOverlayStyles.foreground(colorScheme),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                t.video.player.speed_playing(speedx: '2.0'),
                style: TextStyle(
                  color: VideoOverlayStyles.foreground(colorScheme),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
