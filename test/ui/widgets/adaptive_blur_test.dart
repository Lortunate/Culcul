import 'package:culcul/core/perf/performance_policy.dart';
import 'package:culcul/ui/widgets/media/adaptive_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PerformancePolicy originalPolicy;

  setUp(() {
    originalPolicy = PerformancePolicyController.notifier.value;
  });

  tearDown(() {
    PerformancePolicyController.notifier.value = originalPolicy;
  });

  testWidgets('degrades blur by default under frame pressure', (tester) async {
    PerformancePolicyController.notifier.value = const PerformancePolicy.reducedEffects();

    await tester.pumpWidget(
      const MaterialApp(home: AdaptiveBlur(child: SizedBox(width: 32, height: 32))),
    );

    expect(find.byType(BackdropFilter), findsNothing);
  });

  testWidgets('keeps blur when performance adaptation is disabled', (tester) async {
    PerformancePolicyController.notifier.value = const PerformancePolicy.reducedEffects();

    await tester.pumpWidget(
      const MaterialApp(
        home: AdaptiveBlur(
          adaptToPerformancePolicy: false,
          child: SizedBox(width: 32, height: 32),
        ),
      ),
    );

    expect(find.byType(BackdropFilter), findsOneWidget);
  });
}
