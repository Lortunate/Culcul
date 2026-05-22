import 'package:culcul/core/services/audio_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  tearDown(() async {
    await CilixiliAudioHandler.debugResetShared();
  });

  test('shared audio handler disposes idempotently and recreates', () async {
    final firstPlatform = _FakePlatformPlayer();
    CilixiliAudioHandler.debugSetPlayerFactory(
      () => Player(platformPlayer: firstPlatform),
    );

    final first = CilixiliAudioHandler.shared;
    expect(first.isDisposed, isFalse);

    await first.dispose();
    await first.dispose();
    expect(first.isDisposed, isTrue);
    expect(firstPlatform.disposeCount, 1);

    final secondPlatform = _FakePlatformPlayer();
    CilixiliAudioHandler.debugSetPlayerFactory(
      () => Player(platformPlayer: secondPlatform),
    );

    final second = CilixiliAudioHandler.shared;
    expect(second, isNot(same(first)));
    expect(second.isDisposed, isFalse);

    await second.dispose();
    expect(secondPlatform.disposeCount, 1);
  });
}

class _FakePlatformPlayer extends PlatformPlayer {
  _FakePlatformPlayer() : super(configuration: const PlayerConfiguration());

  int disposeCount = 0;

  @override
  Future<void> dispose() async {
    disposeCount++;
    await super.dispose();
  }

  @override
  Future<void> play() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> seek(Duration duration) async {}

  @override
  Future<void> stop() async {}
}
