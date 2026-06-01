import 'dart:async';

import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'playback_snapshot_view_model.g.dart';

final class PlaybackSnapshot {
  const PlaybackSnapshot({
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.buffer = Duration.zero,
  });

  final Duration position;
  final Duration duration;
  final Duration buffer;

  PlaybackSnapshot copyWith({Duration? position, Duration? duration, Duration? buffer}) {
    return PlaybackSnapshot(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      buffer: buffer ?? this.buffer,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is PlaybackSnapshot &&
            other.position == position &&
            other.duration == duration &&
            other.buffer == buffer;
  }

  @override
  int get hashCode => Object.hash(runtimeType, position, duration, buffer);

  @override
  String toString() {
    return 'PlaybackSnapshot(position: $position, duration: $duration, '
        'buffer: $buffer)';
  }
}

class _PlaybackSnapshotQuantizer {
  static const int _positionStepMs = 250;
  static const int _bufferStepMs = 500;

  static Duration quantizePosition(Duration value) {
    final ms = value.inMilliseconds;
    if (ms <= 0) return Duration.zero;
    return Duration(milliseconds: (ms ~/ _positionStepMs) * _positionStepMs);
  }

  static Duration quantizeBuffer(Duration value) {
    final ms = value.inMilliseconds;
    if (ms <= 0) return Duration.zero;
    return Duration(milliseconds: (ms ~/ _bufferStepMs) * _bufferStepMs);
  }
}

@riverpod
Stream<PlaybackSnapshot> playbackSnapshot(Ref ref) {
  final player = ref.watch(playerControllerProvider.notifier).player;
  final controller = StreamController<PlaybackSnapshot>();
  final subscriptions = <StreamSubscription<dynamic>>[];

  var current = PlaybackSnapshot(
    position: _PlaybackSnapshotQuantizer.quantizePosition(player.state.position),
    duration: player.state.duration,
    buffer: _PlaybackSnapshotQuantizer.quantizeBuffer(player.state.buffer),
  );
  controller.add(current);

  void emit({Duration? position, Duration? duration, Duration? buffer}) {
    var next = current;
    if (position != null) next = next.copyWith(position: position);
    if (duration != null) next = next.copyWith(duration: duration);
    if (buffer != null) next = next.copyWith(buffer: buffer);
    if (next != current) {
      current = next;
      controller.add(current);
    }
  }

  subscriptions.addAll([
    player.stream.position.listen((position) {
      emit(position: _PlaybackSnapshotQuantizer.quantizePosition(position));
    }),
    player.stream.duration.listen((duration) {
      emit(duration: duration);
    }),
    player.stream.buffer.listen((buffer) {
      emit(buffer: _PlaybackSnapshotQuantizer.quantizeBuffer(buffer));
    }),
  ]);

  ref.onDispose(() async {
    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
    await controller.close();
  });

  return controller.stream;
}

@riverpod
PlaybackSnapshot playbackSnapshotValue(Ref ref) {
  return ref
      .watch(playbackSnapshotProvider)
      .maybeWhen(data: (value) => value, orElse: () => const PlaybackSnapshot());
}

@riverpod
Duration playbackPosition(Ref ref) {
  return ref.watch(playbackSnapshotValueProvider.select((value) => value.position));
}

@riverpod
Duration playbackDuration(Ref ref) {
  return ref.watch(playbackSnapshotValueProvider.select((value) => value.duration));
}

@riverpod
Duration playbackBuffer(Ref ref) {
  return ref.watch(playbackSnapshotValueProvider.select((value) => value.buffer));
}
