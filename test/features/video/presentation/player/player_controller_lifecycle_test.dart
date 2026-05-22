import 'package:culcul/core/services/audio_handler.dart';
import 'package:culcul/features/video/presentation/player/player_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async {
    await CilixiliAudioHandler.debugResetShared();
  });

  test('build does not duplicate player lifecycle wiring', () {
    final platformPlayer = _FakePlatformPlayer();
    CilixiliAudioHandler.debugSetPlayerFactory(
      () => Player(platformPlayer: platformPlayer),
    );
    final audioHandler = CilixiliAudioHandler.shared;
    final container = ProviderContainer(
      overrides: [audioHandlerProvider.overrideWithValue(audioHandler)],
    );
    var containerDisposed = false;
    addTearDown(() {
      if (!containerDisposed) {
        container.dispose();
      }
    });

    container.read(playerControllerProvider);
    final controller = container.read(playerControllerProvider.notifier);
    final player = controller.player;
    final videoController = controller.videoController;

    expect(controller.debugActiveMediaSubscriptionCount, 2);
    expect(controller.debugHasActiveControlsTimer, isTrue);

    controller.runBuild();

    expect(controller.player, same(player));
    expect(controller.videoController, same(videoController));
    expect(controller.debugActiveMediaSubscriptionCount, 2);
    expect(controller.debugHasActiveControlsTimer, isTrue);

    container.dispose();
    containerDisposed = true;

    expect(controller.debugActiveMediaSubscriptionCount, 0);
    expect(controller.debugHasActiveControlsTimer, isFalse);
    expect(platformPlayer.stopCount, 1);
  });
}

final class _FakePlatformPlayer extends PlatformPlayer {
  _FakePlatformPlayer() : super(configuration: const PlayerConfiguration());

  int stopCount = 0;

  @override
  Future<void> play() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> seek(Duration duration) async {}

  @override
  Future<void> stop() async {
    stopCount++;
  }
}
