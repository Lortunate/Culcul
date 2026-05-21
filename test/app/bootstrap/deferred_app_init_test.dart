import 'package:culcul/app/bootstrap/deferred_app_init.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('scheduleAfterFirstFrame defers media init until a frame completes', (
    tester,
  ) async {
    var mediaInitCalls = 0;
    final controller = DeferredAppInitController.testing(
      initializeMediaKit: () {
        mediaInitCalls += 1;
      },
    );

    controller.scheduleAfterFirstFrame();

    expect(mediaInitCalls, 0);

    await tester.pumpWidget(const SizedBox.shrink());

    expect(mediaInitCalls, 1);
  });
}
