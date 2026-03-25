import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoLayer extends ConsumerWidget {
  final BoxFit fit;
  const VideoLayer({super.key, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerController = ref.watch(playerControllerProvider.notifier);
    final controller = playerController.videoController;

    return Video(controller: controller, controls: (state) => const SizedBox(), fit: fit);
  }
}

