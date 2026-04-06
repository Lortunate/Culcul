import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:culcul/core/perf/video_perf_logger.dart';
import 'package:culcul/core/services/audio_handler.dart';
import 'package:culcul/features/video/presentation/view_models/player_session_coordinator.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_view_model.freezed.dart';
part 'player_view_model.g.dart';

@freezed
sealed class PlayerUiState with _$PlayerUiState {
  const factory PlayerUiState({
    @Default(false) bool isPlaying,
    @Default(false) bool isBuffering,
    @Default(false) bool isMediaReady,
    @Default(0) int renderEpoch,
    @Default(false) bool isFullscreen,
    @Default(false) bool isLocked,
    @Default(true) bool showControls,
    String? activeSessionId,
    @Default(0) int activationVersion,
  }) = _PlayerUiState;
}

@riverpod
class PlayerController extends _$PlayerController {
  static const Duration _candidateOpenTimeout = Duration(seconds: 8);
  static const Duration _mediaReadyTimeout = Duration(seconds: 6);

  late final Player player;
  late final VideoController videoController;

  Timer? _controlsTimer;
  final List<StreamSubscription> _subscriptions = [];
  final PlayerSessionCoordinator _sessionCoordinator = PlayerSessionCoordinator();
  int _renderEpoch = 0;
  bool _mounted = true;
  bool _controlsInteractionLogged = false;

  @override
  PlayerUiState build() {
    _mounted = true;
    final audioHandler = ref.watch(audioHandlerProvider);
    player = audioHandler.player;
    videoController = VideoController(player);
    ref.onDispose(() {
      _mounted = false;
      _controlsTimer?.cancel();
      for (final s in _subscriptions) {
        s.cancel();
      }
      unawaited(_stopPlaybackSilently());
    });

    _startHideTimer();

    if (_mounted) {
      _subscriptions.addAll([
        player.stream.playing.listen((p) {
          if (_mounted) {
            state = state.copyWith(isPlaying: p);
          }
        }),
        player.stream.buffering.listen((b) {
          if (_mounted) {
            state = state.copyWith(isBuffering: b);
          }
        }),
      ]);
    }

    return PlayerUiState(
      isPlaying: player.state.playing,
      isBuffering: player.state.buffering,
      isMediaReady: false,
      renderEpoch: _renderEpoch,
      activeSessionId: _sessionCoordinator.activeSessionId,
      activationVersion: _sessionCoordinator.activationVersion,
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
        return;
      }

      final candidate = candidates[i];
      final media = Media(candidate, httpHeaders: httpHeaders);

      try {
        if (isQualitySwitch) {
          await _openMediaWithTimeout(media, play: false, ensureStarted: false);
          if (!_isLoadRequestActive(sessionId, requestToken)) {
            return;
          }

          await player.seek(currentPos);
          if (wasPlaying) {
            await player.play();
          }
        } else {
          await _openMediaWithTimeout(media, play: autoPlay, ensureStarted: autoPlay);
          if (!_isLoadRequestActive(sessionId, requestToken)) {
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
      Error.throwWithStackTrace(errorToThrow, stackToThrow);
    }
  }

  bool _isLoadRequestActive(String sessionId, int requestToken) {
    if (!_mounted) {
      return false;
    }
    return _sessionCoordinator.isLoadRequestCurrent(
      requestToken: requestToken,
      sessionId: sessionId,
    );
  }

  void _markReadyForRequest(String sessionId, int requestToken) {
    if (!_isLoadRequestActive(sessionId, requestToken)) {
      return;
    }
    VideoPerfLogger.log(
      VideoPerfEvent.firstFrameReady,
      fields: <String, Object?>{
        'session': sessionId,
        'token': requestToken,
        'positionMs': player.state.position.inMilliseconds,
      },
    );
    state = state.copyWith(isMediaReady: true);
  }

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
