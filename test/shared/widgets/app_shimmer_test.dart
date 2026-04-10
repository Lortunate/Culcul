import 'package:culcul/shared/perf/frame_timing_sampler.dart';
import 'package:culcul/shared/widgets/app_shimmer.dart';
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

  testWidgets('AppShimmer animates when performance policy stays normal', (tester) async {
    FrameTimingSampler.summaryNotifier.value = const FrameTimingSummary(
      samples: 120,
      buildP50Us: 2500,
      buildP95Us: 5500,
      rasterP50Us: 2800,
      rasterP95Us: 6200,
      jankRatio: 0.04,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AppShimmer(child: SizedBox(width: 40, height: 20))),
      ),
    );

    expect(find.byType(ShaderMask), findsOneWidget);
  });

  testWidgets('AppShimmer degrades to static placeholder under heavy jank', (
    tester,
  ) async {
    FrameTimingSampler.summaryNotifier.value = const FrameTimingSummary(
      samples: 120,
      buildP50Us: 9000,
      buildP95Us: 18000,
      rasterP50Us: 9500,
      rasterP95Us: 20000,
      jankRatio: 0.42,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AppShimmer(child: SizedBox(width: 40, height: 20))),
      ),
    );
    await tester.pump();

    expect(find.byType(ShaderMask), findsNothing);
  });
}
