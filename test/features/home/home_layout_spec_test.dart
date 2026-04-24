import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

int _crossAxisCount(HomeGridLayoutSpec spec) {
  return spec.gridDelegate.crossAxisCount;
}

Future<T> _readFromContext<T>({
  required WidgetTester tester,
  required Size size,
  required T Function(BuildContext context) reader,
}) async {
  late T value;

  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: Builder(
          builder: (context) {
            value = reader(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );

  return value;
}

void main() {
  testWidgets('recommend grid columns follow breakpoints', (tester) async {
    final mobile = await _readFromContext(
      tester: tester,
      size: const Size(390, 844),
      reader: HomeGridLayoutSpec.recommend,
    );
    final tablet = await _readFromContext(
      tester: tester,
      size: const Size(800, 900),
      reader: HomeGridLayoutSpec.recommend,
    );
    final desktop = await _readFromContext(
      tester: tester,
      size: const Size(1200, 900),
      reader: HomeGridLayoutSpec.recommend,
    );
    final xl = await _readFromContext(
      tester: tester,
      size: const Size(1600, 900),
      reader: HomeGridLayoutSpec.recommend,
    );

    expect(_crossAxisCount(mobile), 2);
    expect(_crossAxisCount(tablet), 3);
    expect(_crossAxisCount(desktop), 4);
    expect(_crossAxisCount(xl), 5);
  });

  testWidgets('live grid columns follow breakpoints', (tester) async {
    final mobile = await _readFromContext(
      tester: tester,
      size: const Size(390, 844),
      reader: HomeGridLayoutSpec.live,
    );
    final tablet = await _readFromContext(
      tester: tester,
      size: const Size(800, 900),
      reader: HomeGridLayoutSpec.live,
    );
    final desktop = await _readFromContext(
      tester: tester,
      size: const Size(1200, 900),
      reader: HomeGridLayoutSpec.live,
    );
    final xl = await _readFromContext(
      tester: tester,
      size: const Size(1600, 900),
      reader: HomeGridLayoutSpec.live,
    );

    expect(_crossAxisCount(mobile), 2);
    expect(_crossAxisCount(tablet), 3);
    expect(_crossAxisCount(desktop), 4);
    expect(_crossAxisCount(xl), 5);
  });

  testWidgets('desktop popular container keeps narrow max width', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResponsiveContentContainer(
            maxWidth: AppBreakpoints.homePopularMaxWidth,
            horizontalPadding: 0,
            child: SizedBox(width: double.infinity, height: 20),
          ),
        ),
      ),
    );

    final constrainedBox = find.byWidgetPredicate(
      (widget) =>
          widget is ConstrainedBox &&
          widget.constraints.maxWidth == AppBreakpoints.homePopularMaxWidth,
    );
    expect(constrainedBox, findsOneWidget);
  });

  testWidgets('popular list layout scales up card dimensions on desktop', (tester) async {
    final mobile = await _readFromContext(
      tester: tester,
      size: const Size(390, 844),
      reader: HomePopularLayoutSpec.fromContext,
    );
    final desktop = await _readFromContext(
      tester: tester,
      size: const Size(1366, 900),
      reader: HomePopularLayoutSpec.fromContext,
    );

    expect(desktop.cardHeight, greaterThan(mobile.cardHeight));
    expect(desktop.thumbnailWidth, greaterThan(mobile.thumbnailWidth));
  });

  testWidgets('home list cache budgets stay tighter on mobile layouts', (tester) async {
    final mobileRecommend = await _readFromContext(
      tester: tester,
      size: const Size(390, 844),
      reader: HomeGridLayoutSpec.recommend,
    );
    final desktopRecommend = await _readFromContext(
      tester: tester,
      size: const Size(1366, 900),
      reader: HomeGridLayoutSpec.recommend,
    );
    final mobilePopular = await _readFromContext(
      tester: tester,
      size: const Size(390, 844),
      reader: HomePopularLayoutSpec.fromContext,
    );
    final desktopPopular = await _readFromContext(
      tester: tester,
      size: const Size(1366, 900),
      reader: HomePopularLayoutSpec.fromContext,
    );

    expect(mobileRecommend.cacheExtent, lessThan(desktopRecommend.cacheExtent));
    expect(mobilePopular.cacheExtent, lessThan(desktopPopular.cacheExtent));
  });
}
