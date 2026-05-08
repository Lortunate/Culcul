import 'package:culcul/features/video/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VideoCard forwards long press to injected callback', (tester) async {
    var longPressCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VideoCard(
            bvid: 'BV1',
            title: 'title',
            coverUrl: 'https://example.com/pic.jpg',
            author: 'owner',
            duration: 120,
            viewCount: 1,
            danmakuCount: 1,
            onLongPress: () => longPressCount++,
          ),
        ),
      ),
    );

    await tester.longPress(find.byType(VideoCard));
    await tester.pump();

    expect(longPressCount, 1);
  });
}
