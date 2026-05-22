import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/services/audio_handler.dart';
import 'package:culcul/features/video/presentation/player/player_session_coordinator.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_view_model.freezed.dart';
part 'player_view_model.g.dart';
part 'player_view_model.controls.dart';
part 'player_view_model.load.dart';
part 'player_view_model.load_helpers.dart';

const Duration _candidateOpenTimeout = Duration(seconds: 8);
const Duration _mediaReadyTimeout = Duration(seconds: 6);

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
class PlayerController extends _$PlayerController
    with
        _PlayerControllerControlsMixin,
        _PlayerControllerLoadMixin,
        _PlayerControllerLoadHelpersMixin {
  @override
  Player get player {
    final current = _player;
    if (current == null) {
      throw StateError('PlayerController player is not initialized');
    }
    return current;
  }

  @override
  VideoController get videoController {
    final current = _videoController;
    if (current == null) {
      throw StateError('PlayerController videoController is not initialized');
    }
    return current;
  }

  Player? _player;
  VideoController? _videoController;
  @override
  Timer? _controlsTimer;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  @override
  final PlayerSessionCoordinator _sessionCoordinator = PlayerSessionCoordinator();
  @override
  final Map<int, Stopwatch> _loadRequestTimings = <int, Stopwatch>{};
  @override
  int _renderEpoch = 0;
  @override
  bool _mounted = true;
  @override
  bool _controlsInteractionLogged = false;
  bool _disposeRegistered = false;

  @visibleForTesting
  int get debugActiveMediaSubscriptionCount => _subscriptions.length;

  @visibleForTesting
  bool get debugHasActiveControlsTimer => _controlsTimer?.isActive ?? false;

  @override
  PlayerUiState build() {
    _mounted = true;
    final audioHandler = ref.watch(audioHandlerProvider);
    _ensurePlayerLifecycle(audioHandler.player);

    return PlayerUiState(
      isPlaying: player.state.playing,
      isBuffering: player.state.buffering,
      renderEpoch: _renderEpoch,
      activeSessionId: _sessionCoordinator.activeSessionId,
      activationVersion: _sessionCoordinator.activationVersion,
    );
  }

  void _ensurePlayerLifecycle(Player nextPlayer) {
    if (!_disposeRegistered) {
      _disposeRegistered = true;
      ref.onDispose(_disposePlayerLifecycle);
    }

    if (identical(_player, nextPlayer) && _videoController != null) {
      return;
    }

    _releasePlayerLifecycle();
    _player = nextPlayer;
    _videoController = VideoController(nextPlayer);
    _startHideTimer();
    _subscriptions.addAll([
      nextPlayer.stream.playing.listen((p) {
        if (_mounted) {
          state = state.copyWith(isPlaying: p);
        }
      }),
      nextPlayer.stream.buffering.listen((b) {
        if (_mounted) {
          state = state.copyWith(isBuffering: b);
        }
      }),
    ]);
  }

  void _disposePlayerLifecycle() {
    _mounted = false;
    if (_player != null) {
      unawaited(_stopPlaybackSilently());
    }
    _releasePlayerLifecycle();
  }

  void _releasePlayerLifecycle() {
    _controlsTimer?.cancel();
    _controlsTimer = null;
    final subscriptions = List<StreamSubscription<dynamic>>.of(_subscriptions);
    _subscriptions.clear();
    _player = null;
    _videoController = null;
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
  }
}
