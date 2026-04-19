import 'package:culcul/shared/widgets/video_actions_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('video actions bottom sheet is constructible', () {
    expect(
      VideoActionsBottomSheet(
        watchLaterLabel: 'Watch later',
        downloadCoverLabel: 'Download cover',
        onWatchLaterTap: () {},
        onDownloadCoverTap: () {},
      ),
      isA<Widget>(),
    );
  });

  Future<void> pumpSheet(
    WidgetTester tester, {
    required VoidCallback onWatchLaterTap,
    required VoidCallback onDownloadCoverTap,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoActionsBottomSheet(
            watchLaterLabel: 'Watch later',
            downloadCoverLabel: 'Download cover',
            onWatchLaterTap: onWatchLaterTap,
            onDownloadCoverTap: onDownloadCoverTap,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders available actions', (tester) async {
    await pumpSheet(tester, onWatchLaterTap: () {}, onDownloadCoverTap: () {});

    expect(find.text('Watch later'), findsOneWidget);
    expect(find.text('Download cover'), findsOneWidget);
  });

  testWidgets('invokes callbacks when action items are tapped', (tester) async {
    var watchLaterTapped = 0;
    var downloadCoverTapped = 0;

    await pumpSheet(
      tester,
      onWatchLaterTap: () => watchLaterTapped++,
      onDownloadCoverTap: () => downloadCoverTapped++,
    );

    await tester.tap(find.text('Watch later'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Download cover'));
    await tester.pumpAndSettle();

    expect(watchLaterTapped, 1);
    expect(downloadCoverTapped, 1);
  });
}
