import 'package:culcul/i18n/i18n.dart';
import 'dart:ui';

import 'package:culcul/app/theme/app_theme.dart';
import 'package:culcul/features/video/presentation/view_model/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/view_model/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_model/video_detail_view_model.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_settings_sheet.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoListenPage extends ConsumerWidget {
  final String bvid;

  const VideoListenPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final playerState = ref.watch(playerControllerProvider);
    final playerController = ref.read(playerControllerProvider.notifier);
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final semanticColors = context.semanticColors;

    final detail = state.videoDetail;
    final t = i18n(context);

    final sleepTimerTarget = playerState.sleepTimerTarget;
    String? sleepTimerText;
    if (sleepTimerTarget != null) {
      final remaining = sleepTimerTarget.difference(DateTime.now());
      if (remaining.inSeconds > 0) {
        sleepTimerText = t.video.sleep_timer_remaining(
          remaining: remaining.formatDuration,
        );
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
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colorScheme.onPrimary,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          t.video.listen,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz_rounded, color: colorScheme.onPrimary),
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
          Positioned.fill(
            child: AppNetworkImage(url: detail.pic, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: semanticColors.overlayBackground),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: colorScheme.onPrimary.withValues(alpha: 0.12),
                        width: 4,
                      ),
                    ),
                    child: ClipOval(
                      child: AppNetworkImage(url: detail.pic, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 48),

                  Text(
                    detail.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    detail.owner.name,
                    style: TextStyle(
                      color: colorScheme.onPrimary.withValues(alpha: 0.7),
                      fontSize: 15,
                    ),
                  ),
                  if (sleepTimerText != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        sleepTimerText,
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 48),

                  Column(
                    children: [
                      SliderTheme(
                        data: PlayerTheme.progressSliderTheme(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                        ),
                        child: Slider(
                          value: position.inMilliseconds.toDouble().clamp(
                            0.0,
                            duration.inMilliseconds.toDouble(),
                          ),
                          max: duration.inMilliseconds.toDouble() > 0
                              ? duration.inMilliseconds.toDouble()
                              : 1.0,
                          onChanged: (value) {
                            playerController.seek(Duration(milliseconds: value.toInt()));
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
                                color: colorScheme.onPrimary.withValues(alpha: 0.5),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              duration.formatDuration,
                              style: TextStyle(
                                color: colorScheme.onPrimary.withValues(alpha: 0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.repeat_rounded,
                          color: colorScheme.onPrimary.withValues(alpha: 0.5),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final newPos = position - const Duration(seconds: 15);
                          playerController.seek(
                            newPos < Duration.zero ? Duration.zero : newPos,
                          );
                        },
                        icon: Icon(
                          Icons.replay_10_rounded,
                          color: colorScheme.onPrimary,
                          size: 28,
                        ),
                      ),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: playerController.playOrPause,
                          icon: Icon(
                            playerState.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: colorScheme.onPrimary,
                            size: 36,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final newPos = position + const Duration(seconds: 15);
                          playerController.seek(newPos > duration ? duration : newPos);
                        },
                        icon: Icon(
                          Icons.forward_10_rounded,
                          color: colorScheme.onPrimary,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.playlist_play_rounded,
                          color: colorScheme.onPrimary.withValues(alpha: 0.5),
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
