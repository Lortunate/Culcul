import 'package:culcul/providers/video/danmaku_settings_provider.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/subtitle_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/widgets/controls/controls_utils.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_bottom_bar.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_settings_sheet.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_theme.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_top_bar.dart';
import 'package:culcul/ui/pages/video/widgets/controls/quick_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerControlsOverlay extends HookConsumerWidget {
  final String bvid;
  final VoidCallback onClose;
  final VoidCallback? onListen;
  final VoidCallback? onToggleFullscreen;
  final VoidCallback? onNext;

  const PlayerControlsOverlay({
    super.key,
    required this.bvid,
    required this.onClose,
    this.onListen,
    this.onToggleFullscreen,
    this.onNext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only rebuild this widget when controls visibility or lock state changes
    final showControls = ref.watch(playerControllerProvider.select((s) => s.showControls));
    final isLocked = ref.watch(playerControllerProvider.select((s) => s.isLocked));
    final playerController = ref.read(playerControllerProvider.notifier);
    final videoDetailState = ref.watch(videoDetailControllerProvider(bvid));

    return AnimatedOpacity(
      opacity: showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Stack(
        children: [
          if (!isLocked) ...[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100,
              child: IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: PlayerTheme.topGradient,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 160,
              child: IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: PlayerTheme.bottomGradient,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                ignoring: !showControls,
                child: SafeArea(
                  bottom: false,
                  child: PlayerTopBar(
                    title: videoDetailState.videoDetail?.title,
                    onClose: onClose,
                    onMore: () => _showSettings(context, ref),
                    onListen: onListen,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                ignoring: !showControls,
                child: SafeArea(
                  top: false,
                  child: Consumer(
                    builder: (context, ref, _) {
                       final playerState = ref.watch(playerControllerProvider);
                       return PlayerBottomBar(
                          position: playerState.position,
                          duration: playerState.duration,
                          bufferedPosition: playerState.buffer,
                          isPlaying: playerState.isPlaying,
                          isBuffering: playerState.isBuffering,
                          onPlayPause: playerController.playOrPause,
                          onSeek: playerController.seek,
                          onNext: onNext,
                          onFullscreen: onToggleFullscreen ?? playerController.toggleFullscreen,
                          bvid: bvid,
                       );
                    }
                  ),
                ),
              ),
            ),
          ],
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: IgnorePointer(
                ignoring: !showControls,
                child: _LockButton(
                  isLocked: isLocked,
                  onTap: playerController.toggleLock,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context, WidgetRef ref) {
    showSidePanel(
      context,
      PlayerSettingsSheet(
        bvid: bvid,
        isBottomSheet: MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }
}

class _LockButton extends StatelessWidget {
  final bool isLocked;
  final VoidCallback onTap;

  const _LockButton({required this.isLocked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
            color: isLocked ? Theme.of(context).primaryColor : Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
