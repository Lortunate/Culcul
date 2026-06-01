import 'dart:async';

import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'listen_sleep_timer_view_model.g.dart';

const int minListenSleepMinutes = 1;
const int maxListenSleepMinutes = 720;

final class ListenSleepTimerState {
  const ListenSleepTimerState({this.remaining, this.total});

  final Duration? remaining;
  final Duration? total;

  bool get isActive => remaining != null && remaining! > Duration.zero;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ListenSleepTimerState &&
            other.remaining == remaining &&
            other.total == total;
  }

  @override
  int get hashCode => Object.hash(remaining, total);

  @override
  String toString() {
    return 'ListenSleepTimerState(remaining: $remaining, total: $total)';
  }
}

@Riverpod(keepAlive: true)
Future<void> Function() listenSleepTimerOnExpire(Ref ref) {
  return () async {
    await ref.read(playerControllerProvider.notifier).player.stop();
  };
}

@Riverpod(keepAlive: true)
class ListenSleepTimerController extends _$ListenSleepTimerController {
  Timer? _ticker;
  DateTime? _deadline;
  Duration? _total;

  @override
  ListenSleepTimerState build() {
    ref.onDispose(_dispose);
    return const ListenSleepTimerState();
  }

  void setPresetMinutes(int minutes) {
    setCustomMinutes(minutes);
  }

  void setCustomMinutes(int minutes) {
    final clampedMinutes = minutes.clamp(minListenSleepMinutes, maxListenSleepMinutes);
    setForDuration(Duration(minutes: clampedMinutes));
  }

  void setForDuration(Duration duration) {
    if (duration <= Duration.zero) {
      clearTimer();
      return;
    }

    _ticker?.cancel();
    _total = duration;
    _deadline = DateTime.now().add(duration);
    _emitRemaining();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _emitRemaining();
    });
  }

  void clearTimer() {
    _ticker?.cancel();
    _ticker = null;
    _deadline = null;
    _total = null;
    state = const ListenSleepTimerState();
  }

  void _emitRemaining() {
    final deadline = _deadline;
    final total = _total;
    if (deadline == null || total == null) {
      clearTimer();
      return;
    }

    final remaining = deadline.difference(DateTime.now());
    if (remaining <= Duration.zero) {
      _expire();
      return;
    }

    state = ListenSleepTimerState(remaining: remaining, total: total);
  }

  void _expire() {
    clearTimer();
    unawaited(ref.read(listenSleepTimerOnExpireProvider)());
  }

  void _dispose() {
    _ticker?.cancel();
    _ticker = null;
  }
}
