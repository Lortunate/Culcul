import 'package:culcul/providers/video/danmaku_settings_provider.dart';
import 'package:culcul/providers/video/player_controller.dart';
import 'package:culcul/providers/video/subtitle_controller.dart';
import 'package:culcul/providers/video/video_detail_controller.dart';
import 'package:culcul/ui/pages/video/widgets/controls/controls_utils.dart';
import 'package:culcul/ui/pages/video/widgets/controls/player_theme.dart';
import 'package:culcul/ui/pages/video/widgets/controls/quick_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerBottomBar extends ConsumerStatefulWidget {
  final Duration position;
  final Duration duration;
  final Duration bufferedPosition;
  final bool isPlaying;
  final bool isBuffering;
  final VoidCallback onPlayPause;
  final ValueChanged<Duration> onSeek;
  final VoidCallback? onNext;
  final VoidCallback onFullscreen;
  final String bvid;

  const PlayerBottomBar({
    super.key,
    required this.position,
    required this.duration,
    this.bufferedPosition = Duration.zero,
    required this.isPlaying,
    this.isBuffering = false,
    required this.onPlayPause,
    required this.onSeek,
    this.onNext,
    required this.onFullscreen,
    required this.bvid,
  });

  @override
  ConsumerState<PlayerBottomBar> createState() => _PlayerBottomBarState();
}

class _PlayerBottomBarState extends ConsumerState<PlayerBottomBar> {
  double? _dragValue;
  bool _isDragging = false;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (duration.inHours > 0) {
      return '${duration.inHours}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _showQualityMenu(
    BuildContext context,
    int selectedQuality,
    List<int> availableQualities,
    Map<int, String> qualityLabels,
  ) {
    showSidePanel(
      context,
      QuickSelectionSheet<int>(
        title: '选择画质',
        items: availableQualities,
        selectedItem: selectedQuality,
        labelBuilder: (q) => qualityLabels[q] ?? '未知',
        onSelected: (q) {
          ref.read(videoDetailControllerProvider(widget.bvid).notifier).switchQuality(q);
        },
        isBottomSheet: MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }

  void _showSpeedMenu(BuildContext context, double currentSpeed) {
    const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    showSidePanel(
      context,
      QuickSelectionSheet<double>(
        title: '播放速度',
        items: speeds,
        selectedItem: currentSpeed,
        labelBuilder: (s) => '${s}x',
        onSelected: (s) {
          ref.read(videoDetailControllerProvider(widget.bvid).notifier).setPlaybackSpeed(s);
          ref.read(playerControllerProvider.notifier).player.setRate(s);
        },
        isBottomSheet: MediaQuery.of(context).orientation == Orientation.portrait,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Providers
    final danmakuEnabled = ref.watch(danmakuSettingsControllerProvider.select((s) => s.isEnabled));
    final subtitleState = ref.watch(subtitleControllerProvider(widget.bvid));
    final videoDetailState = ref.watch(videoDetailControllerProvider(widget.bvid));
    final isFullscreen = ref.watch(playerControllerProvider.select((s) => s.isFullscreen));

    // Derived State
    final selectedQuality = videoDetailState.selectedQuality;
    final availableQualities = videoDetailState.availableQualities;
    final playbackSpeed = videoDetailState.playbackSpeed;
    
    final qualityLabels = <int, String>{};
    if (videoDetailState.playUrl != null) {
        final qualities = videoDetailState.playUrl!.acceptQuality;
        final descs = videoDetailState.playUrl!.acceptDescription;
        for (int i = 0; i < qualities.length && i < descs.length; i++) {
            qualityLabels[qualities[i]] = descs[i];
        }
    }

    // Progress Calculation
    final double value = _isDragging
        ? _dragValue!
        : widget.position.inMilliseconds.toDouble();
    final double max = widget.duration.inMilliseconds.toDouble();
    final safeMax = max > 0 ? max : 1.0;
    final safeValue = value.clamp(0.0, safeMax);

    final double bufferValue = widget.bufferedPosition.inMilliseconds
        .toDouble()
        .clamp(0.0, safeMax);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 12,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Buffering Progress
                if (safeMax > 1.0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          width: constraints.maxWidth * (bufferValue / safeMax),
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        );
                      },
                    ),
                  ),
                // Seek Slider
                SliderTheme(
                  data: PlayerTheme.sliderTheme.copyWith(
                    inactiveTrackColor: Colors.transparent,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8,
                      elevation: 2,
                    ),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    trackHeight: 2,
                  ),
                  child: Slider(
                    value: safeValue,
                    min: 0.0,
                    max: safeMax,
                    onChanged: (val) {
                      setState(() {
                        _isDragging = true;
                        _dragValue = val;
                      });
                    },
                    onChangeEnd: (val) {
                      widget.onSeek(Duration(milliseconds: val.toInt()));
                      setState(() {
                        _isDragging = false;
                        _dragValue = null;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Row(
            children: [
              _ControlButton(
                onPressed: widget.onPlayPause,
                icon: widget.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                size: 28,
              ),
              if (widget.onNext != null) ...[
                const SizedBox(width: 4),
                _ControlButton(
                  onPressed: widget.onNext,
                  icon: Icons.skip_next_rounded,
                  size: 24,
                ),
              ],
              const SizedBox(width: 8),
              Text(
                '${_formatDuration(Duration(milliseconds: safeValue.toInt()))} / ${_formatDuration(widget.duration)}',
                style: PlayerTheme.timeStyle.copyWith(fontSize: 10),
              ),
              const Spacer(),
              if (isFullscreen) ...[
                _PlayerCapsuleButton(
                  text: '${playbackSpeed}X',
                  onTap: () => _showSpeedMenu(context, playbackSpeed),
                ),
                const SizedBox(width: 8),
                _PlayerCapsuleButton(
                  text: qualityLabels[selectedQuality] ?? '自动',
                  onTap: () => _showQualityMenu(context, selectedQuality, availableQualities, qualityLabels),
                ),
                const SizedBox(width: 8),
                _ControlButton(
                  onPressed: () {
                     ref.read(danmakuSettingsControllerProvider.notifier).setEnabled(!danmakuEnabled);
                  },
                  icon: danmakuEnabled
                      ? Icons.notes_rounded
                      : Icons.notes_outlined,
                  color: danmakuEnabled
                      ? colorScheme.primary
                      : Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 4),
                // Subtitle Toggle
                if (subtitleState.availableSubtitles.isNotEmpty) ...[
                  _ControlButton(
                    onPressed: () {
                       ref.read(subtitleControllerProvider(widget.bvid).notifier).toggleSubtitle();
                    },
                    icon: subtitleState.isEnabled
                        ? Icons.closed_caption_rounded
                        : Icons.closed_caption_off_rounded,
                    color: subtitleState.isEnabled
                        ? colorScheme.primary
                        : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                ],
              ],
              _ControlButton(
                onPressed: widget.onFullscreen,
                icon: isFullscreen
                    ? Icons.fullscreen_exit_rounded
                    : Icons.fullscreen_rounded,
                size: 26,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color color;

  const _ControlButton({
    this.onPressed,
    required this.icon,
    required this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            HapticFeedback.lightImpact();
            onPressed!();
          }
        },
        borderRadius: BorderRadius.circular(size),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              icon,
              key: ValueKey(icon),
              color: color,
              size: size,
              shadows: const [Shadow(blurRadius: 4, color: Colors.black45)],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerCapsuleButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PlayerCapsuleButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
