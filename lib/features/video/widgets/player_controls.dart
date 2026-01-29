import 'package:flutter/material.dart';
import 'package:cilixili/core/theme/app_colors.dart';

class PlayerControlsOverlay extends StatelessWidget {
  final bool isVisible;
  final int selectedQuality;
  final List<int> availableQualities;
  final double playbackSpeed;
  final VoidCallback onClose;
  final ValueChanged<int> onQualityChanged;
  final ValueChanged<double> onSpeedChanged;
  final VoidCallback onFullscreenToggle;
  final Map<int, String> qualityLabels;

  const PlayerControlsOverlay({
    super.key,
    required this.isVisible,
    required this.selectedQuality,
    required this.availableQualities,
    required this.playbackSpeed,
    required this.onClose,
    required this.onQualityChanged,
    required this.onSpeedChanged,
    required this.onFullscreenToggle,
    this.qualityLabels = const {},
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class PlayerProgressBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onSeek;
  final bool isBuffering;

  const PlayerProgressBar({
    super.key,
    required this.duration,
    required this.position,
    required this.onSeek,
    this.isBuffering = false,
  });

  @override
  State<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends State<PlayerProgressBar> {
  late double _dragValue;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _dragValue = widget.position.inMilliseconds.toDouble();
  }

  @override
  void didUpdateWidget(PlayerProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isDragging) {
      _dragValue = widget.position.inMilliseconds.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}

class PlayerBottomBar extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onSettings;
  final bool isLoading;

  const PlayerBottomBar({
    super.key,
    required this.position,
    required this.duration,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onSettings,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
