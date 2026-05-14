part of 'player_view_model.dart';

mixin _PlayerControllerLoadHelpersMixin
    on _$PlayerController, _PlayerControllerLoadMixin {
  @override
  bool _isLoadRequestActive(String sessionId, int requestToken) {
    if (!_mounted) {
      return false;
    }
    return _sessionCoordinator.isLoadRequestCurrent(
      requestToken: requestToken,
      sessionId: sessionId,
    );
  }

  @override
  void _markReadyForRequest(String sessionId, int requestToken) {
    if (!_isLoadRequestActive(sessionId, requestToken)) {
      return;
    }
    final requestTiming = _loadRequestTimings.remove(requestToken);
    final elapsedMs = requestTiming?.elapsedMilliseconds;
    DevLogger.log('video', 'first_frame_ready', <String, Object?>{
      'session': sessionId,
      'token': requestToken,
      'elapsedMs': elapsedMs,
      'positionMs': player.state.position.inMilliseconds,
    });
    state = state.copyWith(isMediaReady: true);
  }

  @override
  Future<void> _openMediaWithTimeout(
    Media media, {
    required bool play,
    required bool ensureStarted,
  }) async {
    await player.open(media, play: play).timeout(_candidateOpenTimeout);

    if (!ensureStarted) {
      return;
    }

    if (player.state.duration > Duration.zero || player.state.position > Duration.zero) {
      return;
    }

    await Future.any([
      player.stream.duration.firstWhere((d) => d > Duration.zero),
      player.stream.position.firstWhere((p) => p > Duration.zero),
    ]).timeout(_mediaReadyTimeout);
  }
}
