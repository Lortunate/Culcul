import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';

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

  _audioServiceInitFuture = _initializeCulculAudioService(builder: builder);
  await _audioServiceInitFuture;
}

Future<void> _initializeCulculAudioService({
  required AudioHandler Function() builder,
}) async {
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
    if (kDebugMode) {
      debugPrint('AudioService init failed: $error');
    }
  } finally {
    _audioServiceInitFuture = null;
  }
}
