import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/overlays/video_actions_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return TranslationProvider(
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  test('video actions bottom sheet is constructible', () {
    expect(
      VideoActionsBottomSheet(
        onWatchLater: () {},
        onDownloadCover: () {},
      ),
      isA<Widget>(),
    );
  });

  Future<void> pumpSheet(
    WidgetTester tester, {
    required VoidCallback onWatchLater,
    required VoidCallback onDownloadCover,
  }) async {
    await tester.pumpWidget(
      _wrap(
        VideoActionsBottomSheet(
          onWatchLater: onWatchLater,
          onDownloadCover: onDownloadCover,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders available actions', (tester) async {
    await pumpSheet(tester, onWatchLater: () {}, onDownloadCover: () {});

    final context = tester.element(find.byType(VideoActionsBottomSheet));
    final t = Translations.of(context);

    expect(find.text(t.home.video_more.watch_later), findsOneWidget);
    expect(find.text(t.home.video_more.download_cover), findsOneWidget);
  });

  testWidgets('invokes callbacks when action items are tapped', (tester) async {
    var watchLaterTapped = 0;
    var downloadCoverTapped = 0;

    await pumpSheet(
      tester,
      onWatchLater: () => watchLaterTapped++,
      onDownloadCover: () => downloadCoverTapped++,
    );

    final context = tester.element(find.byType(VideoActionsBottomSheet));
    final t = Translations.of(context);

    await tester.tap(find.text(t.home.video_more.watch_later));
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.home.video_more.download_cover));
    await tester.pumpAndSettle();

    expect(watchLaterTapped, 1);
    expect(downloadCoverTapped, 1);
  });
}
