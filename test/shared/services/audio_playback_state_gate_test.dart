import 'package:audio_service/audio_service.dart';
import 'package:culcul/core/services/audio_playback_state_gate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('quantizes position and buffer by configured step', () {
    final gate = AudioPlaybackStateGate(
      positionStep: const Duration(milliseconds: 250),
      minEmitInterval: const Duration(milliseconds: 250),
    );

    final snapshot = gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: false,
      playing: true,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 499),
      bufferedPosition: const Duration(milliseconds: 751),
      speed: 1,
      now: DateTime(2026, 1, 1, 0, 0, 0),
    );

    expect(snapshot, isNotNull);
    expect(snapshot!.position, const Duration(milliseconds: 250));
    expect(snapshot.bufferedPosition, const Duration(milliseconds: 750));
  });

  test('suppresses duplicate snapshots', () {
    final gate = AudioPlaybackStateGate();
    final baseTime = DateTime(2026, 1, 1, 0, 0, 0);

    final first = gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: false,
      playing: true,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 10),
      bufferedPosition: const Duration(milliseconds: 10),
      speed: 1,
      now: baseTime,
    );
    final second = gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: false,
      playing: true,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 120),
      bufferedPosition: const Duration(milliseconds: 120),
      speed: 1,
      now: baseTime.add(const Duration(milliseconds: 600)),
    );

    expect(first, isNotNull);
    expect(second, isNull);
  });

  test('throttles non-critical updates within min interval', () {
    final gate = AudioPlaybackStateGate(
      positionStep: const Duration(milliseconds: 250),
      minEmitInterval: const Duration(milliseconds: 250),
    );
    final baseTime = DateTime(2026, 1, 1, 0, 0, 0);

    gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: false,
      playing: true,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 260),
      bufferedPosition: const Duration(milliseconds: 260),
      speed: 1,
      now: baseTime,
    );

    final throttled = gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: false,
      playing: true,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 510),
      bufferedPosition: const Duration(milliseconds: 510),
      speed: 1,
      now: baseTime.add(const Duration(milliseconds: 100)),
    );

    expect(throttled, isNull);
  });

  test('critical updates bypass throttle window', () {
    final gate = AudioPlaybackStateGate(
      positionStep: const Duration(milliseconds: 250),
      minEmitInterval: const Duration(milliseconds: 250),
    );
    final baseTime = DateTime(2026, 1, 1, 0, 0, 0);

    gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: false,
      playing: true,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 260),
      bufferedPosition: const Duration(milliseconds: 260),
      speed: 1,
      now: baseTime,
    );

    final critical = gate.nextSnapshotIfShouldEmit(
      isCriticalEvent: true,
      playing: false,
      processingState: AudioProcessingState.ready,
      position: const Duration(milliseconds: 510),
      bufferedPosition: const Duration(milliseconds: 510),
      speed: 1,
      now: baseTime.add(const Duration(milliseconds: 100)),
    );

    expect(critical, isNotNull);
    expect(critical!.playing, isFalse);
  });
}
