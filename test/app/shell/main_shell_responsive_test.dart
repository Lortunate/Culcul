import 'package:culcul/app/shell/main_shell.dart';
import 'package:culcul/app/shell/navigation_items.dart';
import 'package:culcul/shared/perf/frame_timing_sampler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildShellForWidth(double width) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(size: Size(width, 900)),
      child: AdaptiveShellScaffold(
        body: const SizedBox.expand(),
        currentIndex: 0,
        onDestinationSelected: (_) {},
        labels: const ['Home', 'Dynamic', 'Ranking', 'Profile'],
        items: NavigationItems.items,
      ),
    ),
  );
}

void main() {
  late FrameTimingSummary? originalSummary;

  setUp(() {
    originalSummary = FrameTimingSampler.summaryNotifier.value;
    FrameTimingSampler.summaryNotifier.value = null;
  });

  tearDown(() {
    FrameTimingSampler.summaryNotifier.value = originalSummary;
  });

  testWidgets('shows BottomNavigationBar on mobile width', (tester) async {
    await tester.pumpWidget(_buildShellForWidth(390));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('keeps bottom navigation blur on mobile width during high jank', (
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

    await tester.pumpWidget(_buildShellForWidth(390));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
  });

  testWidgets('shows compact NavigationRail on desktop width >= 1024', (tester) async {
    await tester.pumpWidget(_buildShellForWidth(1100));

    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.extended, isFalse);
    expect(find.byType(BottomNavigationBar), findsNothing);
  });

  testWidgets('shows extended NavigationRail on desktop width >= 1280', (tester) async {
    await tester.pumpWidget(_buildShellForWidth(1400));

    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.extended, isTrue);
    expect(find.byType(BottomNavigationBar), findsNothing);
  });
}
