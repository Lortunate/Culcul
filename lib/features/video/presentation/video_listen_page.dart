import 'dart:ui';

import 'package:culcul/features/video/controllers/player_controller.dart';
import 'package:culcul/features/video/controllers/video_detail_controller.dart';
import 'package:culcul/shared/format_extensions.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_settings_sheet.dart';
import 'package:culcul/app/theme/app_colors.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoListenPage extends HookConsumerWidget {
  final String bvid;

  const VideoListenPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final playerState = ref.watch(playerControllerProvider);
    final playerController = ref.read(playerControllerProvider.notifier);
    final player = playerController.player;

    final positionSnapshot = useStream(player.stream.position);
    final durationSnapshot = useStream(player.stream.duration);
    final position = positionSnapshot.data ?? Duration.zero;
    final duration = durationSnapshot.data ?? Duration.zero;

    final detail = state.videoDetail;

    final sleepTimerTarget = playerState.sleepTimerTarget;
    String? sleepTimerText;
    if (sleepTimerTarget != null) {
      final remaining = sleepTimerTarget.difference(DateTime.now());
      if (remaining.inSeconds > 0) {
        sleepTimerText = '定时关闭: ${remaining.formatDuration}';
      }
    }

    if (detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          '听视频',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return PlayerSettingsSheet(
                    bvid: bvid,
                    sleepTimerTarget: playerState.sleepTimerTarget,
                    onSetSleepTimer: (duration) {
                      if (duration == null) {
                        playerController.cancelSleepTimer();
                      } else {
                        playerController.setSleepTimer(duration);
                      }
                      Navigator.pop(context);
                    },
                    isBottomSheet: true,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Blurred Background
          Positioned.fill(
            child: AppNetworkImage(url: detail.pic, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.black.withValues(alpha: 0.6)),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  // Cover Art
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(color: Colors.white12, width: 4),
                    ),
                    child: ClipOval(
                      child: AppNetworkImage(
                        url: detail.pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Info
                  Text(
                    detail.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    detail.owner.name,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 15,
                    ),
                  ),
                  if (sleepTimerText != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        sleepTimerText,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 48),

                  // Progress
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2,
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6,
                          ),
                          overlayColor: AppColors.primary.withValues(
                            alpha: 0.2,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 16,
                          ),
                        ),
                        child: Slider(
                          value: position.inMilliseconds
                              .toDouble()
                              .clamp(
                                0.0,
                                duration.inMilliseconds.toDouble(),
                              ),
                          max: duration.inMilliseconds.toDouble() > 0 ? duration.inMilliseconds.toDouble() : 1.0,
                          onChanged: (value) {
                            playerController.seek(
                              Duration(milliseconds: value.toInt()),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              position.formatDuration,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              duration.formatDuration,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {}, // TODO: Playlist loop
                        icon: Icon(
                          Icons.repeat_rounded,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // -15s
                          final newPos =
                              position -
                              const Duration(seconds: 15);
                          playerController.seek(
                            newPos < Duration.zero ? Duration.zero : newPos,
                          );
                        },
                        icon: const Icon(
                          Icons.replay_10_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: playerController.playOrPause,
                          icon: Icon(
                            playerState.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // +15s
                          final newPos =
                              position +
                              const Duration(seconds: 15);
                          playerController.seek(
                            newPos > duration
                                ? duration
                                : newPos,
                          );
                        },
                        icon: const Icon(
                          Icons.forward_10_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {}, // TODO: Playlist list
                        icon: Icon(
                          Icons.playlist_play_rounded,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
