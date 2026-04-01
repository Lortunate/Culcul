import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';

class MyNotifier extends Notifier<AsyncValue<List<String>>> {
  @override
  AsyncValue<List<String>> build() => const AsyncValue.data(['Item 1']);

  void setState(AsyncValue<List<String>> newState) {
    state = newState;
  }
}

void main() {
  testWidgets('SmartPagingView transitions do not crash', (tester) async {
    final provider = NotifierProvider<MyNotifier, AsyncValue<List<String>>>(
      MyNotifier.new,
    );
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(
          child: MaterialApp(
            home: HookConsumer(
              builder: (context, ref, child) {
                final asyncValue = ref.watch(provider);
                return SmartPagingView<String>(
                  asyncValue: asyncValue,
                  builder: (context, items) => ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (c, i) => Text(items[i]),
                  ),
                  skeleton: const Text('Skeleton'),
                  onRefresh: () async {},
                  onLoadMore: () async {},
                  provider: provider,
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Initial state: Data
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.byType(EasyRefresh), findsOneWidget);

    // Switch to loading
    container.read(provider.notifier).setState(const AsyncValue.loading());
    await tester.pumpAndSettle();

    // With AnimatedSwitcher removed, it should be Skeleton immediately
    expect(find.text('Skeleton'), findsOneWidget);
    expect(find.byType(EasyRefresh), findsNothing);

    // Switch back to data
    container.read(provider.notifier).setState(const AsyncValue.data(['Item 2']));
    await tester.pumpAndSettle();

    // Should be back to Data
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.byType(EasyRefresh), findsOneWidget);
  });

  testWidgets('SmartPagingView renders AppEmptyStateWidget for empty data', (
    tester,
  ) async {
    final provider = NotifierProvider<MyNotifier, AsyncValue<List<String>>>(
      MyNotifier.new,
    );
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(
          child: MaterialApp(
            home: HookConsumer(
              builder: (context, ref, child) {
                final asyncValue = ref.watch(provider);
                return SmartPagingView<String>(
                  asyncValue: asyncValue,
                  builder: (context, items) => ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (c, i) => Text(items[i]),
                  ),
                  skeleton: const Text('Skeleton'),
                  onRefresh: () async {},
                  onLoadMore: () async {},
                  provider: provider,
                );
              },
            ),
          ),
        ),
      ),
    );

    container.read(provider.notifier).setState(const AsyncValue.data([]));
    await tester.pumpAndSettle();

    expect(find.byType(AppEmptyStateWidget), findsOneWidget);
  });
}
