import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return TranslationProvider(
    child: MaterialApp(
      home: Scaffold(body: SizedBox(width: 240, height: 320, child: child)),
    ),
  );
}

void main() {
  testWidgets('VideoCard delegates long press to injected callback', (tester) async {
    var longPressed = 0;

    await tester.pumpWidget(
      _wrap(
        VideoCard(
          bvid: 'BV1xx411c7mD',
          title: 'Video title',
          coverUrl: 'https://example.com/cover.jpg',
          author: 'Author',
          duration: 120,
          viewCount: 1,
          danmakuCount: 2,
          onLongPress: () => longPressed++,
        ),
      ),
    );

    await tester.longPress(find.byType(VideoCard));
    await tester.pump();

    expect(longPressed, 1);
  });

  testWidgets('VideoCard opens the shared actions sheet when long pressed', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        VideoCard(
          bvid: 'BV1xx411c7mD',
          title: 'Video title',
          coverUrl: 'https://example.com/cover.jpg',
          author: 'Author',
          duration: 120,
          viewCount: 1,
          danmakuCount: 2,
        ),
      ),
    );

    await tester.longPress(find.byType(VideoCard));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(Icons.watch_later_outlined), findsOneWidget);
    expect(find.byIcon(Icons.image_outlined), findsOneWidget);
  });
}
