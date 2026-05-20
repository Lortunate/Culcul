import 'package:culcul/features/home/presentation/widgets/home_feed_paging_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('HomeFeedPagingShell renders skeleton while loading', (tester) async {
    await tester.pumpWidget(
      _TestApp(
        child: HomeFeedPagingShell<int>(
          maxWidth: 320,
          asyncValue: const AsyncValue.loading(),
          skeleton: const Text('loading-feed'),
          onRefresh: () async {},
          builder: (context, items) => Text('items-${items.length}'),
        ),
      ),
    );

    expect(find.text('loading-feed'), findsOneWidget);
    expect(find.text('items-0'), findsNothing);
  });

  testWidgets('HomeFeedPagingShell passes data items to builder', (tester) async {
    await tester.pumpWidget(
      _TestApp(
        child: HomeFeedPagingShell<int>(
          maxWidth: 320,
          asyncValue: const AsyncValue.data([1, 2, 3]),
          skeleton: const Text('loading-feed'),
          onRefresh: () async {},
          builder: (context, items) => Text('items-${items.length}'),
        ),
      ),
    );

    expect(find.text('items-3'), findsOneWidget);
  });

  testWidgets('HomeFeedPagingShell requires load-more stop criteria', (tester) async {
    expect(
      () => HomeFeedPagingShell<int>(
        maxWidth: 320,
        asyncValue: const AsyncValue.data([]),
        skeleton: const Text('loading-feed'),
        onRefresh: () async {},
        onLoadMore: () async {},
        builder: (context, items) => Text('items-${items.length}'),
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: child));
  }
}
