import 'dart:ui';

import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/core/theme/culcul_colors.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/features/video/presentation/player/hooks/use_listen_audio_mode.dart';
import 'package:culcul/features/video/presentation/player/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/listen_settings_sheet.dart';
import 'package:culcul/features/video/presentation/player/controls/player_theme.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoListenPage extends HookConsumerWidget {
  final String bvid;

  const VideoListenPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listenState = ref.watch(
      videoDetailControllerProvider(bvid).select(
        (state) => (
          detail: state.videoDetail,
          currentCid: state.currentCid,
          selectedQuality: state.selectedQuality,
          playUrl: state.playUrl,
        ),
      ),
    );
    final detail = listenState.detail;
    final colorScheme = Theme.of(context).colorScheme;
    final overlayColor = context.semanticColors.overlayBackground;
    final t = context.t;
    useListenAudioMode(ref, (
      aid: detail?.aid,
      currentCid: listenState.currentCid,
      selectedQuality: listenState.selectedQuality,
      playUrl: listenState.playUrl,
    ));

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
                builder: (_) => const ListenSettingsSheet(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              AppNetworkImage(url: detail.pic),
              RepaintBoundary(
                child: IgnorePointer(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: AppNetworkImage(url: detail.pic, useShimmer: false),
                  ),
                ),
              ),
              ColoredBox(color: overlayColor),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  RepaintBoundary(
                    child: Container(
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
                      child: ClipOval(child: AppNetworkImage(url: detail.pic)),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Column(
                    children: [
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
                    ],
                  ),
                  const SizedBox(height: 48),
                  const RepaintBoundary(child: _ProgressBar()),
                  const SizedBox(height: 24),
                  const _PlaybackControls(),
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

class _ProgressBar extends HookConsumerWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final playerController = ref.read(playerControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final draggingValue = useState<double?>(null);

    final maxDuration = duration.inMilliseconds.toDouble();
    final validMax = maxDuration > 0 ? maxDuration : 1.0;
    final currentValue = (draggingValue.value ?? position.inMilliseconds.toDouble())
        .clamp(0.0, validMax);

    final textStyle = TextStyle(
      color: colorScheme.onPrimary.withValues(alpha: 0.5),
      fontSize: 12,
    );

    return Column(
      children: [
        SliderTheme(
          data: PlayerTheme.progressSliderTheme(
            context,
          ).copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6)),
          child: Slider(
            value: currentValue,
            max: validMax,
            onChanged: (value) => draggingValue.value = value,
            onChangeEnd: (value) {
              draggingValue.value = null;
              playerController.seek(Duration(milliseconds: value.toInt()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(position.formatDuration, style: textStyle),
              Text(duration.formatDuration, style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaybackControls extends ConsumerWidget {
  const _PlaybackControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(playerControllerProvider.select((s) => s.isPlaying));
    final playerController = ref.read(playerControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            final position = ref.read(playbackPositionProvider);
            final newPos = position - const Duration(seconds: 10);
            playerController.seek(newPos < Duration.zero ? Duration.zero : newPos);
          },
          icon: Icon(Icons.replay_10_rounded, color: onPrimary, size: 28),
        ),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
          child: IconButton(
            onPressed: playerController.playOrPause,
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: onPrimary,
              size: 36,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final position = ref.read(playbackPositionProvider);
            final duration = ref.read(playbackDurationProvider);
            final newPos = position + const Duration(seconds: 10);
            playerController.seek(newPos > duration ? duration : newPos);
          },
          icon: Icon(Icons.forward_10_rounded, color: onPrimary, size: 28),
        ),
      ],
    );
  }
}
