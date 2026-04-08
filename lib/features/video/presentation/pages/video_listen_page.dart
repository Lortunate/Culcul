import 'dart:ui';

import 'package:culcul/app/theme/app_theme.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/video/presentation/hooks/use_listen_audio_mode.dart';
import 'package:culcul/features/video/presentation/view_models/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/listen_settings_sheet.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'video_listen_page.widgets.dart';
part 'video_listen_page.controls.dart';

class VideoListenPage extends HookConsumerWidget {
  final String bvid;

  const VideoListenPage({super.key, required this.bvid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(videoDetailControllerProvider(bvid));
    final detail = detailState.videoDetail;
    final colorScheme = Theme.of(context).colorScheme;
    final t = i18n(context);
    useListenAudioMode(ref, (
      aid: detail?.aid,
      currentCid: detailState.currentCid,
      selectedQuality: detailState.selectedQuality,
      playUrl: detailState.playUrl,
    ));

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
                  RepaintBoundary(child: _CoverArt(imageUrl: detail.pic)),
                  const SizedBox(height: 48),
                  _TrackInfo(title: detail.title, author: detail.owner.name),
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
        style: TextStyle(color: onPrimary, fontSize: 17, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_horiz_rounded, color: onPrimary),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) => const ListenSettingsSheet(isBottomSheet: true),
            );
          },
        ),
      ],
    );
  }
}
