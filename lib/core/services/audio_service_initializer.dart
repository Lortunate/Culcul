import 'package:audio_service/audio_service.dart';
import 'package:culcul/core/perf/dev_logger.dart';

const String _audioNotificationChannelId = 'com.lortunate.culcul.channel.audio';
const String _audioNotificationChannelName = 'Video Playback';

Future<void>? _audioServiceInitFuture;
bool _audioServiceInitialized = false;

Future<void> initializeCulculAudioService({
  required AudioHandler Function() builder,
}) async {
  if (_audioServiceInitialized) {
    return;
  }

  final existing = _audioServiceInitFuture;
  if (existing != null) {
    await existing;
    return;
  }

  final initFuture = () async {
    try {
      await AudioService.init(
        builder: builder,
        config: const AudioServiceConfig(
          androidNotificationChannelId: _audioNotificationChannelId,
          androidNotificationChannelName: _audioNotificationChannelName,
          androidNotificationOngoing: true,
        ),
      );
      _audioServiceInitialized = true;
    } catch (error) {
      DevLogger.log('startup', 'audio_service.init_failed', <String, Object?>{
        'error': error,
      });
    } finally {
      _audioServiceInitFuture = null;
    }
  }();
  _audioServiceInitFuture = initFuture;
  await initFuture;
}
