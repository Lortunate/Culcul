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
  bool _isLoadRequestActive(String sessionId, int requestToken);
  void _markReadyForRequest(String sessionId, int requestToken);
  Future<void> _openMediaWithTimeout(
    Media media, {
    required bool play,
    required bool ensureStarted,
  });

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
      throw ArgumentError.value(urls, 'urls', 'At least one playable url is required.');
    }

    final currentPos = player.state.position;
    final wasPlaying = state.isPlaying;

    Object? lastError;
    StackTrace? lastStackTrace;

    for (var i = 0; i < candidates.length; i++) {
      if (!_isLoadRequestActive(sessionId, requestToken)) {
        _loadRequestTimings.remove(requestToken);
        return;
      }

      final candidate = candidates[i];
      final media = Media(candidate, httpHeaders: httpHeaders);

      try {
        if (isQualitySwitch) {
          await _openMediaWithTimeout(media, play: false, ensureStarted: false);
          if (!_isLoadRequestActive(sessionId, requestToken)) {
            _loadRequestTimings.remove(requestToken);
            return;
          }

          await player.seek(currentPos);
          if (wasPlaying) {
            await player.play();
          }
        } else {
          await _openMediaWithTimeout(media, play: autoPlay, ensureStarted: autoPlay);
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
        _markReadyForRequest(sessionId, requestToken);
        return;
      } catch (error, stackTrace) {
        if (!_isLoadRequestActive(sessionId, requestToken)) {
          _loadRequestTimings.remove(requestToken);
          return;
        }
        lastError = error;
        lastStackTrace = stackTrace;
        debugPrint(
          'PlayerController.loadVideo failed for candidate ${i + 1}/${candidates.length}: $error',
        );
        await _stopPlaybackSilently();
      }
    }

    final errorToThrow = lastError;
    final stackToThrow = lastStackTrace;
    if (errorToThrow != null &&
        stackToThrow != null &&
        _isLoadRequestActive(sessionId, requestToken)) {
      _loadRequestTimings.remove(requestToken);
      Error.throwWithStackTrace(errorToThrow, stackToThrow);
    }
    _loadRequestTimings.remove(requestToken);
  }
}
