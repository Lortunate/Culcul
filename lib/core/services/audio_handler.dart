import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

final audioHandlerProvider = Provider<CilixiliAudioHandler>((ref) {
  throw UnimplementedError();
});

class CilixiliAudioHandler extends BaseAudioHandler {
  final Player player = Player();

  CilixiliAudioHandler() {
    _initSession();
    // Propagate player events to AudioService
    player.stream.playing.listen((playing) {
      _broadcastState();
    });

    player.stream.position.listen((position) {
      _broadcastState();
    });

    player.stream.duration.listen((duration) {
      final item = mediaItem.value;
      if (item != null && item.duration != duration) {
        mediaItem.add(item.copyWith(duration: duration));
      }
      _broadcastState();
    });

    player.stream.buffering.listen((buffering) {
      _broadcastState();
    });

    player.stream.buffer.listen((buffer) {
      _broadcastState();
    });

    player.stream.completed.listen((completed) {
      _broadcastState();
    });

    player.stream.error.listen((error) {
      _broadcastState();
    });
  }

  Future<void> _initSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  void _broadcastState() {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        if (player.state.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop, // Or close?
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.playPause,
      },
      androidCompactActionIndices: const [0],
      processingState: _getProcessingState(),
      playing: player.state.playing,
      updatePosition: player.state.position,
      bufferedPosition: player.state.buffer,
      speed: player.state.rate,
      queueIndex: 0,
    ));
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

  static Future<CilixiliAudioHandler> init() async {
    final handler = await AudioService.init(
      builder: () => CilixiliAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.lortunate.culcul.channel.audio',
        androidNotificationChannelName: 'Video Playback',
        androidNotificationOngoing: true,
      ),
    );
    return handler as CilixiliAudioHandler;
  }
}
