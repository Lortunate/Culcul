import 'package:culcul/features/video/presentation/view_models/player_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/controls_utils.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_bottom_bar.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_settings_sheet.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/widgets/controls/player_top_bar.dart';
import 'package:culcul/features/video/presentation/widgets/controls/video_overlay_styles.dart';
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
    final showControls = ref.watch(
      playerControllerProvider.select((s) => s.showControls),
    );
    final isLocked = ref.watch(playerControllerProvider.select((s) => s.isLocked));
    final playerController = ref.read(playerControllerProvider.notifier);
    final videoTitle = ref.watch(
      videoDetailControllerProvider(bvid).select((value) => value.videoDetail?.title),
    );

    void showSettings() {
      showSidePanel(
        context,
        PlayerSettingsSheet(
          bvid: bvid,
          isBottomSheet: MediaQuery.of(context).orientation == Orientation.portrait,
        ),
      );
    }

    return RepaintBoundary(
      child: AnimatedOpacity(
        opacity: showControls ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          children: [
            if (!isLocked) ...[
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 100,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: PlayerTheme.topGradient),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 160,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: PlayerTheme.bottomGradient),
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
                      title: videoTitle,
                      onClose: onClose,
                      onMore: showSettings,
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
                    child: PlayerBottomBar(
                      bvid: bvid,
                      onNext: onNext,
                      onToggleFullscreen: onToggleFullscreen,
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
                    onTap: () {
                      playerController.toggleLock();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: VideoOverlayStyles.panelBackground(colorScheme).withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
            color: isLocked ? colorScheme.primary : colorScheme.onPrimary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
