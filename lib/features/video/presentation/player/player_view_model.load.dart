part of 'player_view_model.dart';

mixin _PlayerControllerLoadMixin on _$PlayerController, _PlayerControllerControlsMixin {
  @override
  Player get player;
  VideoController get videoController;
  PlayerSessionCoordinator get _sessionCoordinator;
  Map<int, Stopwatch> get _loadRequestTimings;
  int get _renderEpoch;
  set _renderEpoch(int value);
  @override
  bool get _mounted;
  @override
  bool get _controlsInteractionLogged;
  @override
  set _controlsInteractionLogged(bool value);
  bool _isLoadRequestActive(String sessionId, int requestToken) {
    if (!_mounted) {
      return false;
    }
    return _sessionCoordinator.isLoadRequestCurrent(
      requestToken: requestToken,
      sessionId: sessionId,
    );
  }

  bool isSessionActive(String sessionId) =>
      _sessionCoordinator.isSessionActive(sessionId);

  Future<void> enterSession(String sessionId) async {
    final change = _sessionCoordinator.enterSession(sessionId);
    if (!change.changed || !_mounted) {
      return;
    }

    _markLoadingForSession(
      activeSessionId: change.activeSessionId,
      activationVersion: change.activationVersion,
      resetUi: true,
      resetPlaybackFlags: true,
    );

    final switchedFromAnotherSession =
        change.previousActiveSessionId != null &&
        change.previousActiveSessionId != sessionId;
    if (switchedFromAnotherSession) {
      await _stopPlaybackSilently();
    }
  }

  Future<void> leaveSession(String sessionId) async {
    final change = _sessionCoordinator.leaveSession(sessionId);
    if (!change.changed || !_mounted) {
      return;
    }

    _markLoadingForSession(
      activeSessionId: change.activeSessionId,
      activationVersion: change.activationVersion,
      resetUi: true,
      resetPlaybackFlags: true,
    );
    await _stopPlaybackSilently();
  }

  void _markLoadingForSession({
    required String? activeSessionId,
    required int activationVersion,
    bool resetUi = false,
    bool resetPlaybackFlags = false,
  }) {
    if (!_mounted) {
      return;
    }

    _renderEpoch++;
    if (resetUi) {
      _controlsInteractionLogged = false;
    }
    state = state.copyWith(
      activeSessionId: activeSessionId,
      activationVersion: activationVersion,
      isMediaReady: false,
      renderEpoch: _renderEpoch,
      isFullscreen: resetUi ? false : state.isFullscreen,
      isLocked: resetUi ? false : state.isLocked,
      showControls: resetUi ? true : state.showControls,
      isPlaying: resetPlaybackFlags ? false : state.isPlaying,
      isBuffering: resetPlaybackFlags ? false : state.isBuffering,
    );
  }

  Future<void> loadVideo(
    List<String> urls, {
    required String sessionId,
    Map<String, String>? httpHeaders,
    bool isQualitySwitch = false,
    bool autoPlay = true,
    String? title,
    String? artist,
    String? coverUrl,
  }) async {
    if (!_sessionCoordinator.isSessionActive(sessionId)) {
      return;
    }

    final requestToken = _sessionCoordinator.beginLoadRequest();
    _loadRequestTimings[requestToken] = Stopwatch()..start();
    _markLoadingForSession(
      activeSessionId: _sessionCoordinator.activeSessionId,
      activationVersion: _sessionCoordinator.activationVersion,
    );

    final candidates = urls
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList(growable: false);
    if (candidates.isEmpty) {
      _loadRequestTimings.remove(requestToken);
      DevLogger.log('video', 'player.load_empty_urls', <String, Object?>{
        'session': sessionId,
      });
      return;
    }

    final currentPos = player.state.position;
    final wasPlaying = state.isPlaying;

    Object? lastError;

    for (var i = 0; i < candidates.length; i++) {
      if (!_isLoadRequestActive(sessionId, requestToken)) {
        _loadRequestTimings.remove(requestToken);
        return;
      }

      final candidate = candidates[i];
      final media = Media(candidate, httpHeaders: httpHeaders);

      try {
        if (isQualitySwitch) {
          await player.open(media, play: false).timeout(_candidateOpenTimeout);
          if (!_isLoadRequestActive(sessionId, requestToken)) {
            _loadRequestTimings.remove(requestToken);
            return;
          }

          await player.seek(currentPos);
          if (wasPlaying) {
            await player.play();
          }
        } else {
          await player.open(media, play: autoPlay).timeout(_candidateOpenTimeout);
          if (autoPlay &&
              player.state.duration <= Duration.zero &&
              player.state.position <= Duration.zero) {
            await Future.any([
              player.stream.duration.firstWhere((duration) => duration > Duration.zero),
              player.stream.position.firstWhere((position) => position > Duration.zero),
            ]).timeout(_mediaReadyTimeout);
          }
          if (!_isLoadRequestActive(sessionId, requestToken)) {
            _loadRequestTimings.remove(requestToken);
            return;
          }
          final audioHandler = ref.read(audioHandlerProvider);
          await audioHandler.updateMediaItem(
            MediaItem(
              id: candidate,
              title: title ?? 'Unknown',
              artist: artist,
              artUri: coverUrl != null ? Uri.parse(coverUrl) : null,
            ),
          );
        }
        if (_isLoadRequestActive(sessionId, requestToken)) {
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
        return;
      } catch (error) {
        if (!_isLoadRequestActive(sessionId, requestToken)) {
          _loadRequestTimings.remove(requestToken);
          return;
        }
        lastError = error;
        DevLogger.log('video', 'player.load_open_failed', <String, Object?>{
          'session': sessionId,
          'candidate': i + 1,
          'candidateCount': candidates.length,
          'error': error,
        });
        await _stopPlaybackSilently();
      }
    }

    final errorToThrow = lastError;
    if (errorToThrow != null && _isLoadRequestActive(sessionId, requestToken)) {
      DevLogger.log('video', 'player.load_retry_failed', <String, Object?>{
        'session': sessionId,
        'candidateCount': candidates.length,
        'error': errorToThrow,
      });
    }
    _loadRequestTimings.remove(requestToken);
  }
}
