import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoLayer extends ConsumerWidget {
  final BoxFit fit;
  const VideoLayer({super.key, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerController = ref.read(playerControllerProvider.notifier);
    final renderState = ref.watch(
      playerControllerProvider.select(
        (value) => (
          isMediaReady: value.isMediaReady,
          renderEpoch: value.renderEpoch,
          activeSessionId: value.activeSessionId,
        ),
      ),
    );
    final key = ValueKey(
      'video:${renderState.activeSessionId ?? 'none'}:${renderState.renderEpoch}',
    );

    if (!renderState.isMediaReady) {
      return ColoredBox(
        color: Colors.black,
        child: renderState.activeSessionId == null
            ? const SizedBox.expand()
            : const Center(
                child: SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
      );
    }

    final controller = playerController.videoController;
    return Video(
      key: key,
      controller: controller,
      controls: (state) => const SizedBox(),
      fit: fit,
    );
  }
}
