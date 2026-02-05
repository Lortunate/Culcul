import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_controller.freezed.dart';
part 'player_controller.g.dart';

@freezed
abstract class PlayerUiState with _$PlayerUiState {
  const factory PlayerUiState({
    @Default(false) bool isPlaying,
    @Default(false) bool isBuffering,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
    @Default(Duration.zero) Duration buffer,
    @Default(false) bool isFullscreen,
    @Default(false) bool isLocked,
    @Default(true) bool showControls,
    DateTime? sleepTimerTarget,
  }) = _PlayerUiState;
}

@riverpod
class PlayerController extends _$PlayerController {
  late final Player player;
  late final VideoController videoController;

  Timer? _controlsTimer;
  Timer? _sleepTimer;
  final List<StreamSubscription> _subscriptions = [];
  bool _mounted = true;

  @override
  PlayerUiState build() {
    _mounted = true;
    player = Player();
    videoController = VideoController(player);
    ref.onDispose(() {
      _mounted = false;
      _controlsTimer?.cancel();
      _sleepTimer?.cancel();
      for (final s in _subscriptions) {
        s.cancel();
      }
      player.dispose();
    });

    // Initialize AudioSession
    Future.microtask(() async {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
    });

    // Initialize the timer to hide controls
    _startHideTimer();

    // Setup listeners after build returns to avoid accessing state during build
    Future.microtask(() {
      if (!_mounted) return;
      _subscriptions.addAll([
        player.stream.position.listen((p) {
          state = state.copyWith(position: p);
        }),
        player.stream.duration.listen((d) {
          state = state.copyWith(duration: d);
        }),
        player.stream.buffer.listen((b) {
          state = state.copyWith(buffer: b);
        }),
        player.stream.playing.listen((p) {
          state = state.copyWith(isPlaying: p);
        }),
        player.stream.buffering.listen((b) {
          state = state.copyWith(isBuffering: b);
        }),
      ]);
    });

    return PlayerUiState(
      isPlaying: player.state.playing,
      position: player.state.position,
      duration: player.state.duration,
      buffer: player.state.buffer,
      isBuffering: player.state.buffering,
    );
  }

  void _startHideTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 4), () {
      if (_mounted && state.isPlaying && !state.isLocked) {
        state = state.copyWith(showControls: false);
      }
    });
  }

  void resetControlsTimer() {
    _controlsTimer?.cancel();
    if (!state.showControls) {
      state = state.copyWith(showControls: true);
    }
    _startHideTimer();
  }

  void toggleControls() {
    if (state.showControls) {
      _controlsTimer?.cancel();
      state = state.copyWith(showControls: false);
    } else {
      resetControlsTimer();
    }
  }

  Future<void> playOrPause() async {
    resetControlsTimer();
    await player.playOrPause();
  }

  Future<void> seek(Duration position) async {
    resetControlsTimer();
    await player.seek(position);
  }

  Future<void> loadVideo(
    String url, {
    Map<String, String>? httpHeaders,
    bool isQualitySwitch = false,
    bool autoPlay = true,
  }) async {
    final media = Media(url, httpHeaders: httpHeaders);
    
    if (isQualitySwitch) {
      final currentPos = state.position;
      final wasPlaying = state.isPlaying;
      
      await player.open(media, play: false);
      
      // Wait for duration to be available if needed
      if (player.state.duration == Duration.zero) {
        try {
          await player.stream.duration
              .firstWhere((d) => d > Duration.zero)
              .timeout(const Duration(seconds: 2));
        } catch (_) {}
      }
      
      await player.seek(currentPos);
      if (wasPlaying) {
        await player.play();
      }
    } else {
      await player.open(media, play: autoPlay);
    }
  }

  void toggleFullscreen() {
    state = state.copyWith(isFullscreen: !state.isFullscreen);
    resetControlsTimer();
  }

  void toggleLock() {
    if (!_mounted) return;
    final newIsLocked = !state.isLocked;
    state = state.copyWith(isLocked: newIsLocked);
    if (newIsLocked) {
      state = state.copyWith(showControls: true);
      _controlsTimer?.cancel();
    } else {
      resetControlsTimer();
    }
  }

  void setSleepTimer(Duration duration) {
    _sleepTimer?.cancel();
    final targetTime = DateTime.now().add(duration);
    state = state.copyWith(sleepTimerTarget: targetTime);
    _sleepTimer = Timer(duration, () {
      if (_mounted) {
        player.pause();
        cancelSleepTimer();
      }
    });
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    state = state.copyWith(sleepTimerTarget: null);
  }
}
