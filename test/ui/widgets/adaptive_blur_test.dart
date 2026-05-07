import 'package:culcul/core/perf/frame_timing_sampler.dart';
import 'package:culcul/ui/widgets/media/adaptive_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FrameTimingSummary? originalSummary;

  setUp(() {
    originalSummary = FrameTimingSampler.summaryNotifier.value;
    FrameTimingSampler.summaryNotifier.value = null;
  });

  tearDown(() {
    FrameTimingSampler.summaryNotifier.value = originalSummary;
  });

  testWidgets('AdaptiveBlur keeps blur when jank ratio is low', (tester) async {
    FrameTimingSampler.summaryNotifier.value = const FrameTimingSummary(
      samples: 120,
      buildP50Us: 3000,
      buildP95Us: 6000,
      rasterP50Us: 3500,
      rasterP95Us: 7000,
      jankRatio: 0.05,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AdaptiveBlur(child: SizedBox(width: 40, height: 40))),
      ),
    );

    expect(find.byType(BackdropFilter), findsOneWidget);
  });

  testWidgets('AdaptiveBlur degrades to plain child when jank ratio is high', (
    tester,
  ) async {
    FrameTimingSampler.summaryNotifier.value = const FrameTimingSummary(
      samples: 120,
      buildP50Us: 9000,
      buildP95Us: 18000,
      rasterP50Us: 10000,
      rasterP95Us: 20000,
      jankRatio: 0.45,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AdaptiveBlur(child: SizedBox(width: 40, height: 40))),
      ),
    );
    await tester.pump();

    expect(find.byType(BackdropFilter), findsNothing);
  });
}
