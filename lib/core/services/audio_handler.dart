import 'dart:async';
import 'dart:developer' as developer;

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:culcul/app/bootstrap/deferred_app_init.dart';
import 'package:culcul/core/services/audio_playback_state_gate.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

final audioHandlerProvider = Provider<CilixiliAudioHandler>((ref) {
  DeferredAppInitController.instance.ensureMediaKitInitialized();
  final handler = CilixiliAudioHandler.shared;
  unawaited(handler.initializeAudioServiceIfNeeded());
  ref.onDispose(handler.dispose);
  return handler;
});

class CilixiliAudioHandler extends BaseAudioHandler {
  static const String _loggerName = 'audio.performance';
  static const Duration _broadcastReportInterval = Duration(seconds: 10);

  static final CilixiliAudioHandler _shared = CilixiliAudioHandler._();
  static Future<void>? _audioServiceInitFuture;
  static bool _audioServiceInitialized = false;

  final Player player = Player();
  final AudioPlaybackStateGate _playbackStateGate = AudioPlaybackStateGate();
  final List<StreamSubscription> _subscriptions = [];

  DateTime _broadcastWindowStart = DateTime.now();
  int _broadcastWindowCount = 0;

  CilixiliAudioHandler._() {
    _initSession();
    // Propagate player events to AudioService
    _subscriptions.add(player.stream.playing.listen((playing) {
      _broadcastState(isCriticalEvent: true, reason: 'playing');
    }));

    _subscriptions.add(player.stream.position.listen((position) {
      _broadcastState(isCriticalEvent: false, reason: 'position');
    }));

    _subscriptions.add(player.stream.duration.listen((duration) {
      final item = mediaItem.value;
      if (item != null && item.duration != duration) {
        mediaItem.add(item.copyWith(duration: duration));
      }
      _broadcastState(isCriticalEvent: true, reason: 'duration');
    }));

    _subscriptions.add(player.stream.buffering.listen((buffering) {
      _broadcastState(isCriticalEvent: true, reason: 'buffering');
    }));

    _subscriptions.add(player.stream.buffer.listen((buffer) {
      _broadcastState(isCriticalEvent: true, reason: 'buffer');
    }));

    _subscriptions.add(player.stream.completed.listen((completed) {
      _broadcastState(isCriticalEvent: true, reason: 'completed');
    }));

    _subscriptions.add(player.stream.error.listen((error) {
      _broadcastState(isCriticalEvent: true, reason: 'error');
    }));
  }

  static CilixiliAudioHandler get shared => _shared;

  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
  }

  Future<void> _initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  void _broadcastState({required bool isCriticalEvent, required String reason}) {
    final snapshot = _playbackStateGate.nextSnapshotIfShouldEmit(
      isCriticalEvent: isCriticalEvent,
      playing: player.state.playing,
      processingState: _getProcessingState(),
      position: player.state.position,
      bufferedPosition: player.state.buffer,
      speed: player.state.rate,
    );
    if (snapshot == null) {
      return;
    }

    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          if (snapshot.playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop, // Or close?
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          MediaAction.playPause,
        },
        androidCompactActionIndices: const [0],
        processingState: snapshot.processingState,
        playing: snapshot.playing,
        updatePosition: snapshot.position,
        bufferedPosition: snapshot.bufferedPosition,
        speed: snapshot.speed,
        queueIndex: 0,
      ),
    );
    _recordBroadcast(reason: reason);
  }

  AudioProcessingState _getProcessingState() {
    if (player.state.buffering) {
      return AudioProcessingState.buffering;
    }
    if (player.state.completed) {
      return AudioProcessingState.completed;
    }
    // We don't have a direct error state check from player.state usually,
    // but assuming if not buffering and not completed, it's ready.
    // Ideally we track error from stream.
    return AudioProcessingState.ready;
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> stop() => player.stop();

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    this.mediaItem.add(mediaItem);
  }

  Future<void> initializeAudioServiceIfNeeded() async {
    if (_audioServiceInitialized) {
      return;
    }

    final existing = _audioServiceInitFuture;
    if (existing != null) {
      await existing;
      return;
    }

    _audioServiceInitFuture = _initializeAudioService();
    await _audioServiceInitFuture;
  }

  Future<void> _initializeAudioService() async {
    try {
      await AudioService.init(
        builder: () => shared,
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.lortunate.culcul.channel.audio',
          androidNotificationChannelName: 'Video Playback',
          androidNotificationOngoing: true,
        ),
      );
      _audioServiceInitialized = true;
    } catch (error) {
      if (kDebugMode) {
        debugPrint('AudioService init failed: $error');
      }
    } finally {
      _audioServiceInitFuture = null;
    }
  }

  void _recordBroadcast({required String reason}) {
    if (!kDebugMode && !kProfileMode) {
      return;
    }

    final now = DateTime.now();
    if (_broadcastWindowCount == 0) {
      _broadcastWindowStart = now;
    }
    _broadcastWindowCount++;

    final elapsed = now.difference(_broadcastWindowStart);
    if (elapsed < _broadcastReportInterval) {
      return;
    }

    final seconds = elapsed.inMilliseconds / 1000.0;
    final rate = seconds == 0 ? 0 : _broadcastWindowCount / seconds;
    developer.log(
      'audio_perf playback_state_broadcast '
      'count=$_broadcastWindowCount '
      'window_s=${seconds.toStringAsFixed(2)} '
      'rate=${rate.toStringAsFixed(2)} '
      'reason=$reason',
      name: _loggerName,
    );
    _broadcastWindowStart = now;
    _broadcastWindowCount = 0;
  }
}
