import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:culcul/features/video/presentation/player/playback_snapshot_view_model.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/player/controls/player_settings_sheet.dart';
import 'package:culcul/features/video/presentation/player/controls/player_theme.dart';
import 'package:culcul/features/video/presentation/player/controls/video_control_buttons.dart';
import 'package:culcul/features/video/presentation/player/controls/video_overlay_styles.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final showControls = ref.watch(
      playerControllerProvider.select((s) => s.showControls),
    );
    final isLocked = ref.watch(playerControllerProvider.select((s) => s.isLocked));
    final playerController = ref.read(playerControllerProvider.notifier);
    final videoTitle = ref.watch(
      videoDetailControllerProvider(bvid).select((value) => value.videoDetail?.title),
    );
    final listenCallback = onListen;
    final isDragging = useState(false);
    final dragValue = useState<double?>(null);
    final sliderTheme = PlayerTheme.progressSliderTheme(context);

    if (!showControls && !isLocked) {
      return const RepaintBoundary(child: SizedBox.shrink());
    }

    return RepaintBoundary(
      child: AnimatedOpacity(
        opacity: showControls ? 1.0 : 0.0,
        duration: CulculMotion.standard,
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
                    child: Container(
                      height: PlayerTheme.topBarHeight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: PlayerTheme.horizontalPadding,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: colorScheme.onPrimary,
                            ),
                            iconSize: PlayerTheme.iconSize,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            onPressed: onClose,
                            splashRadius: 20,
                          ),
                          if (videoTitle != null)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: CulculSpacing.xs,
                                ),
                                child: Text(
                                  videoTitle,
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          else
                            const Spacer(),
                          if (listenCallback != null)
                            IconButton(
                              icon: Icon(
                                Icons.headphones_rounded,
                                color: colorScheme.onPrimary,
                              ),
                              iconSize: PlayerTheme.iconSize,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              onPressed: listenCallback,
                              splashRadius: 20,
                            ),
                          IconButton(
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: colorScheme.onPrimary,
                            ),
                            iconSize: PlayerTheme.iconSize,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            onPressed: () {
                              showPlayerSidePanel(
                                context,
                                PlayerSettingsSheet(
                                  bvid: bvid,
                                  isBottomSheet:
                                      MediaQuery.orientationOf(context) ==
                                      Orientation.portrait,
                                ),
                              );
                            },
                            splashRadius: 20,
                          ),
                        ],
                      ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CulculSpacing.sm,
                          ),
                          child: SizedBox(
                            height: 16,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final playerController =
                                    ref.read(playerControllerProvider.notifier);
                                final duration = ref.watch(playbackDurationProvider);
                                final position = ref.watch(playbackPositionProvider);
                                final buffer = ref.watch(playbackBufferProvider);

                                final max = duration.inMilliseconds.toDouble();
                                final safeMax = max > 0 ? max : 1.0;
                                final positionMs = position.inMilliseconds.toDouble();
                                final rawValue = isDragging.value
                                    ? (dragValue.value ?? positionMs)
                                    : positionMs;
                                final safeValue = rawValue.clamp(0.0, safeMax);
                                final safeBufferValue =
                                    buffer.inMilliseconds.toDouble().clamp(0.0, safeMax);

                                return RepaintBoundary(
                                  child: SliderTheme(
                                    data: sliderTheme,
                                    child: Slider(
                                      value: safeValue,
                                      secondaryTrackValue: safeBufferValue,
                                      max: safeMax,
                                      label: Duration(
                                        milliseconds: safeValue.toInt(),
                                      ).formatDuration,
                                      onChanged: max <= 0
                                          ? null
                                          : (val) {
                                              isDragging.value = true;
                                              dragValue.value = val;
                                            },
                                      onChangeEnd: max <= 0
                                          ? null
                                          : (val) {
                                              isDragging.value = false;
                                              dragValue.value = null;
                                              playerController.seek(
                                                Duration(milliseconds: val.toInt()),
                                              );
                                            },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        VideoControlButtons(
                          bvid: bvid,
                          onNext: onNext,
                          onToggleFullscreen: onToggleFullscreen,
                        ),
                      ],
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
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: playerController.toggleLock,
                      borderRadius: BorderRadius.circular(CulculRadius.xl),
                      child: Container(
                        padding: const EdgeInsets.all(CulculSpacing.xs),
                        decoration: BoxDecoration(
                          color: VideoOverlayStyles.panelBackground(
                            colorScheme,
                          ).withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
                          color: isLocked ? colorScheme.primary : colorScheme.onPrimary,
                          size: 22,
                        ),
                      ),
                    ),
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
