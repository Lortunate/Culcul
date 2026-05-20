import 'package:culcul/features/video/presentation/detail/info/video_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VideoCollectionSummary normalizes empty page count', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: VideoCollectionSummary(label: 'Parts', title: 'Demo video', pageCount: 0),
        ),
      ),
    );

    expect(find.text('Parts - Demo video'), findsOneWidget);
    expect(find.text('1/1'), findsOneWidget);
  });
}
