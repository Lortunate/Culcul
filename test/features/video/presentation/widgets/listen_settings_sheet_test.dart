import 'package:culcul/features/video/presentation/view_models/listen_sleep_timer_view_model.dart';
import 'package:culcul/features/video/presentation/widgets/controls/listen_settings_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSheet(WidgetTester tester, ProviderContainer container) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(
          child: const MaterialApp(
            home: Scaffold(body: ListenSettingsSheet(isBottomSheet: true)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  void clearTimer(ProviderContainer container) {
    container.read(listenSleepTimerControllerProvider.notifier).clearTimer();
  }

  testWidgets('listen settings sheet only exposes sleep timer controls', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await pumpSheet(tester, container);

    expect(find.text(t.video.listen_settings.sleep_timer), findsWidgets);
    expect(find.text(t.video.player.choose_quality), findsNothing);
    expect(find.text(t.video.player.choose_speed), findsNothing);
  });

  testWidgets('preset and disable timer actions update timer state', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await pumpSheet(tester, container);

    await tester.tap(find.text(t.video.listen_settings.preset_minutes(minutes: 15)));
    await tester.pumpAndSettle();
    expect(container.read(listenSleepTimerControllerProvider).isActive, isTrue);

    await tester.tap(find.text(t.video.listen_settings.disable));
    await tester.pumpAndSettle();
    expect(container.read(listenSleepTimerControllerProvider).isActive, isFalse);
  });

  testWidgets('invalid custom input shows error and disables set action', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await pumpSheet(tester, container);

    await tester.enterText(find.byType(TextField), '0');
    await tester.pumpAndSettle();

    expect(
      find.text(
        t.video.listen_settings.custom_invalid_range(
          min: minListenSleepMinutes,
          max: maxListenSleepMinutes,
        ),
      ),
      findsOneWidget,
    );

    final setButton = tester.widget<TextButton>(
      find.widgetWithText(TextButton, t.video.listen_settings.set_custom),
    );
    expect(setButton.onPressed, isNull);
  });

  testWidgets('valid custom input enables set action and clears input on submit', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await pumpSheet(tester, container);

    await tester.enterText(find.byType(TextField), '25');
    await tester.pumpAndSettle();

    final setButtonFinder = find.widgetWithText(
      TextButton,
      t.video.listen_settings.set_custom,
    );
    final setButton = tester.widget<TextButton>(setButtonFinder);
    expect(setButton.onPressed, isNotNull);

    await tester.tap(setButtonFinder);
    await tester.pumpAndSettle();

    final timerState = container.read(listenSleepTimerControllerProvider);
    expect(timerState.isActive, isTrue);
    expect(timerState.total?.inMinutes, 25);

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.controller?.text, isEmpty);

    clearTimer(container);
  });

  testWidgets('done action submits custom input', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await pumpSheet(tester, container);

    await tester.enterText(find.byType(TextField), '30');
    await tester.pumpAndSettle();
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final timerState = container.read(listenSleepTimerControllerProvider);
    expect(timerState.isActive, isTrue);
    expect(timerState.total?.inMinutes, 30);

    clearTimer(container);
  });

  testWidgets('selected preset exposes semantics selected state', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await pumpSheet(tester, container);

    final preset15Label = t.video.listen_settings.preset_minutes(minutes: 15);
    await tester.tap(find.text(preset15Label));
    await tester.pumpAndSettle();

    final selectedSemantics = find.byWidgetPredicate(
      (widget) =>
          widget is Semantics &&
          widget.properties.label == preset15Label &&
          widget.properties.selected == true,
    );
    expect(selectedSemantics, findsOneWidget);

    clearTimer(container);
  });
}
