import 'package:media_kit/media_kit.dart';

class MediaRuntimeInitializer {
  MediaRuntimeInitializer._() : _initializeMediaKit = MediaKit.ensureInitialized;

  MediaRuntimeInitializer.testing({required void Function() initializeMediaKit})
    : _initializeMediaKit = initializeMediaKit;

  static final MediaRuntimeInitializer instance = MediaRuntimeInitializer._();

  final void Function() _initializeMediaKit;

  bool _ready = false;

  void ensureInitialized() {
    if (_ready) return;
    _initializeMediaKit();
    _ready = true;
  }
}
