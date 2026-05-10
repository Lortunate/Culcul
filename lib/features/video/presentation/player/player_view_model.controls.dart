part of 'player_view_model.dart';

mixin _PlayerControllerControlsMixin on _$PlayerController {
  Player get player;
  bool get _mounted;
  Timer? get _controlsTimer;
  set _controlsTimer(Timer? value);
  bool get _controlsInteractionLogged;
  set _controlsInteractionLogged(bool value);

  Future<void> _stopPlaybackSilently() async {
    try {
      await player.stop();
    } catch (_) {}
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
    _logControlsInteractionOnce('toggle_controls');
    if (state.showControls) {
      _controlsTimer?.cancel();
      state = state.copyWith(showControls: false);
    } else {
      resetControlsTimer();
    }
  }

  Future<void> playOrPause() async {
    _logControlsInteractionOnce('play_or_pause');
    resetControlsTimer();
    await player.playOrPause();
  }

  Future<void> setPlaybackRate(double rate) async {
    await player.setRate(rate);
  }

  Future<void> seek(Duration position) async {
    _logControlsInteractionOnce('seek');
    resetControlsTimer();
    await player.seek(position);
  }

  void toggleFullscreen() {
    _logControlsInteractionOnce('fullscreen_toggle');
    state = state.copyWith(isFullscreen: !state.isFullscreen);
    resetControlsTimer();
  }

  void toggleLock() {
    _logControlsInteractionOnce('lock_toggle');
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

  void _logControlsInteractionOnce(String action) {
    if (_controlsInteractionLogged) {
      return;
    }
    final sessionId = state.activeSessionId;
    if (sessionId == null || sessionId.isEmpty) {
      return;
    }
    _controlsInteractionLogged = true;
    VideoPerfLogger.log(
      VideoPerfEvent.controlsFirstInteraction,
      fields: <String, Object?>{'session': sessionId, 'action': action},
    );
  }
}
