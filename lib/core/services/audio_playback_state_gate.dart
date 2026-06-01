import 'package:audio_service/audio_service.dart';

final class AudioPlaybackSnapshot {
  const AudioPlaybackSnapshot({
    required this.playing,
    required this.processingState,
    required this.position,
    required this.bufferedPosition,
    required this.speed,
  });

  final bool playing;
  final AudioProcessingState processingState;
  final Duration position;
  final Duration bufferedPosition;
  final double speed;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AudioPlaybackSnapshot &&
            runtimeType == other.runtimeType &&
            playing == other.playing &&
            processingState == other.processingState &&
            position == other.position &&
            bufferedPosition == other.bufferedPosition &&
            speed == other.speed;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      playing,
      processingState,
      position,
      bufferedPosition,
      speed,
    );
  }

  @override
  String toString() {
    return 'AudioPlaybackSnapshot('
        'playing: $playing, '
        'processingState: $processingState, '
        'position: $position, '
        'bufferedPosition: $bufferedPosition, '
        'speed: $speed'
        ')';
  }
}

class AudioPlaybackStateGate {
  AudioPlaybackStateGate({
    this.positionStep = const Duration(milliseconds: 250),
    this.minEmitInterval = const Duration(milliseconds: 250),
  });

  final Duration positionStep;
  final Duration minEmitInterval;

  AudioPlaybackSnapshot? _lastSnapshot;
  DateTime? _lastEmitAt;

  AudioPlaybackSnapshot? nextSnapshotIfShouldEmit({
    required bool isCriticalEvent,
    required bool playing,
    required AudioProcessingState processingState,
    required Duration position,
    required Duration bufferedPosition,
    required double speed,
    DateTime? now,
  }) {
    final normalized = AudioPlaybackSnapshot(
      playing: playing,
      processingState: processingState,
      position: _quantizeDuration(position, positionStep),
      bufferedPosition: _quantizeDuration(bufferedPosition, positionStep),
      speed: speed,
    );

    if (normalized == _lastSnapshot) {
      return null;
    }

    final currentTime = now ?? DateTime.now();
    if (!isCriticalEvent && _lastEmitAt != null) {
      final elapsed = currentTime.difference(_lastEmitAt!);
      if (elapsed < minEmitInterval) {
        return null;
      }
    }

    _lastSnapshot = normalized;
    _lastEmitAt = currentTime;
    return normalized;
  }

  Duration quantizePosition(Duration value) => _quantizeDuration(value, positionStep);

  Duration _quantizeDuration(Duration value, Duration step) {
    final millis = value.inMilliseconds;
    if (millis <= 0) {
      return Duration.zero;
    }
    final stepMs = step.inMilliseconds;
    if (stepMs <= 1) {
      return value;
    }
    return Duration(milliseconds: (millis ~/ stepMs) * stepMs);
  }
}
