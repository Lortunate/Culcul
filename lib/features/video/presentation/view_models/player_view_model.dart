import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:culcul/shared/perf/video_perf_logger.dart';
import 'package:culcul/shared/services/audio_handler.dart';
import 'package:culcul/features/video/presentation/view_models/player_session_coordinator.dart';
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
  late final Player player;
  @override
  late final VideoController videoController;

  @override
  Timer? _controlsTimer;
  final List<StreamSubscription> _subscriptions = [];
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
}
