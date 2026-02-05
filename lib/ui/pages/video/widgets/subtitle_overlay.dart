import 'package:culcul/data/models/subtitle.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/subtitle_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubtitleOverlay extends HookConsumerWidget {
  final String bvid;

  const SubtitleOverlay({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitleState = ref.watch(subtitleControllerProvider(bvid));
    final playerPosition = ref.watch(
      playerControllerProvider.select((value) => value.position),
    );

    if (!subtitleState.isEnabled || subtitleState.content.isEmpty) {
      return const SizedBox();
    }

    final currentSeconds = playerPosition.inMilliseconds / 1000.0;
    
    // Find current subtitle item
    // Since subtitles are usually sorted by time, we can optimize this.
    // For now, a simple iteration is fine for typical subtitle counts.
    final currentItem = subtitleState.content.firstWhere(
      (item) => item.from <= currentSeconds && item.to >= currentSeconds,
      orElse: () => const SubtitleItem(
        from: 0,
        to: 0,
        location: 0,
        content: '',
      ),
    );

    if (currentItem.content.isEmpty) {
      return const SizedBox();
    }

    return Positioned(
      bottom: 24, // Adjust based on bottom bar height
      left: 16,
      right: 16,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            currentItem.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.2,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(0, -1),
                  blurRadius: 2,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(1, 0),
                  blurRadius: 2,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(-1, 0),
                  blurRadius: 2,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
