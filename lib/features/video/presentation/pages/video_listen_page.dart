import 'dart:ui';

import 'package:culcul/app/theme/app_theme.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/view_models/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_settings_sheet.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VideoListenPage extends ConsumerWidget {
  final String bvid;

  const VideoListenPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoDetailControllerProvider(bvid));
    final detail = state.videoDetail;
    final colorScheme = Theme.of(context).colorScheme;
    final t = i18n(context);

    if (detail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context, colorScheme, t.video.listen),
      body: Stack(
        children: [
          _Background(imageUrl: detail.pic),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  _CoverArt(imageUrl: detail.pic),
                  const SizedBox(height: 48),
                  _TrackInfo(title: detail.title, author: detail.owner.name),
                  const SizedBox(height: 48),
                  const _ProgressBar(),
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

  PreferredSizeWidget _buildAppBar(
      BuildContext context,
      ColorScheme colorScheme,
      String title,
      ) {
    final onPrimary = colorScheme.onPrimary;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: onPrimary, size: 32),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: onPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_horiz_rounded, color: onPrimary),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) => PlayerSettingsSheet(bvid: bvid, isBottomSheet: true),
            );
          },
        ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  final String imageUrl;

  const _Background({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final overlayColor = context.semanticColors.overlayBackground;

    return Stack(
      fit: StackFit.expand,
      children: [
        AppNetworkImage(url: imageUrl, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(color: overlayColor),
        ),
      ],
    );
  }
}

class _CoverArt extends StatelessWidget {
  final String imageUrl;

  const _CoverArt({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
        child: AppNetworkImage(url: imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

class _TrackInfo extends StatelessWidget {
  final String title;
  final String author;

  const _TrackInfo({required this.title, required this.author});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          title,
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
          author,
          style: TextStyle(
            color: colorScheme.onPrimary.withValues(alpha: 0.7),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends ConsumerWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final playerController = ref.read(playerControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final maxDuration = duration.inMilliseconds.toDouble();
    final validMax = maxDuration > 0 ? maxDuration : 1.0;
    final currentValue = position.inMilliseconds.toDouble().clamp(0.0, maxDuration);

    final textStyle = TextStyle(
      color: colorScheme.onPrimary.withValues(alpha: 0.5),
      fontSize: 12,
    );

    return Column(
      children: [
        SliderTheme(
          data: PlayerTheme.progressSliderTheme(context).copyWith(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: Slider(
            value: currentValue,
            max: validMax,
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
    final playerState = ref.watch(playerControllerProvider);
    final position = ref.watch(playbackPositionProvider);
    final duration = ref.watch(playbackDurationProvider);
    final playerController = ref.read(playerControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.repeat_rounded, color: onPrimary.withValues(alpha: 0.5)),
        ),
        IconButton(
          onPressed: () {
            final newPos = position - const Duration(seconds: 10);
            playerController.seek(newPos < Duration.zero ? Duration.zero : newPos);
          },
          icon: Icon(Icons.replay_10_rounded, color: onPrimary, size: 28),
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
              playerState.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: onPrimary,
              size: 36,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final newPos = position + const Duration(seconds: 10);
            playerController.seek(newPos > duration ? duration : newPos);
          },
          icon: Icon(Icons.forward_10_rounded, color: onPrimary, size: 28),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.playlist_play_rounded, color: onPrimary.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}