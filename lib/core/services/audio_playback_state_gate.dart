import 'package:audio_service/audio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_playback_state_gate.freezed.dart';

@freezed
sealed class AudioPlaybackSnapshot with _$AudioPlaybackSnapshot {
  const factory AudioPlaybackSnapshot({
    required bool playing,
    required AudioProcessingState processingState,
    required Duration position,
    required Duration bufferedPosition,
    required double speed,
  }) = _AudioPlaybackSnapshot;
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
