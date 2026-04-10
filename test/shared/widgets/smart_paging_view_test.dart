import 'dart:async';

import 'package:culcul/shared/widgets/smart_paging_view.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/app_empty_state_widget.dart';
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

class BoolFlagNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool value) {
    state = value;
  }
}

Future<IndicatorResult> triggerLoad(WidgetTester tester) async {
  final easyRefresh = tester.widget<EasyRefresh>(find.byType(EasyRefresh));
  final onLoad = easyRefresh.onLoad;
  expect(onLoad, isNotNull);
  final result = onLoad!.call();
  if (result is IndicatorResult) {
    return result;
  }
  return await (result as Future<IndicatorResult>);
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
                  itemCount: () => ref.read(provider).value?.length ?? 0,
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
                  itemCount: () => ref.read(provider).value?.length ?? 0,
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

  testWidgets('SmartPagingView onLoad returns noMore when item count is unchanged', (
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
                  itemCount: () => ref.read(provider).value?.length ?? 0,
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final result = await triggerLoad(tester);
    expect(result, IndicatorResult.noMore);
  });

  testWidgets('SmartPagingView onLoad returns fail when loadMore throws', (tester) async {
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
                  onLoadMore: () async => throw Exception('boom'),
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final result = await triggerLoad(tester);
    expect(result, IndicatorResult.fail);
  });

  testWidgets('SmartPagingView onLoad guards concurrent invocations', (tester) async {
    final provider = NotifierProvider<MyNotifier, AsyncValue<List<String>>>(
      MyNotifier.new,
    );
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final completer = Completer<void>();
    var callCount = 0;

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
                  onLoadMore: () async {
                    callCount++;
                    container
                        .read(provider.notifier)
                        .setState(const AsyncValue.data(['Item 1', 'Item 2']));
                    await completer.future;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final easyRefresh = tester.widget<EasyRefresh>(find.byType(EasyRefresh));
    final onLoad = easyRefresh.onLoad;
    expect(onLoad, isNotNull);

    final first = onLoad!.call();
    final second = onLoad.call();

    final secondResult = await second;
    expect(secondResult, IndicatorResult.success);
    expect(callCount, 1);

    completer.complete();
    await tester.pumpAndSettle();

    final firstResult = await first;
    expect(firstResult, IndicatorResult.success);
    expect(callCount, 1);
  });

  testWidgets('SmartPagingView resets load gate when provider changes', (tester) async {
    final providerA = NotifierProvider<MyNotifier, AsyncValue<List<String>>>(
      MyNotifier.new,
    );
    final providerB = NotifierProvider<MyNotifier, AsyncValue<List<String>>>(
      MyNotifier.new,
    );
    final useProviderA = NotifierProvider<BoolFlagNotifier, bool>(BoolFlagNotifier.new);
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final completerA = Completer<void>();
    var callA = 0;
    var callB = 0;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(
          child: MaterialApp(
            home: HookConsumer(
              builder: (context, ref, child) {
                final useA = ref.watch(useProviderA);
                final provider = useA ? providerA : providerB;
                final asyncValue = ref.watch(provider);
                return SmartPagingView<String>(
                  asyncValue: asyncValue,
                  builder: (context, items) => ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (c, i) => Text(items[i]),
                  ),
                  skeleton: const Text('Skeleton'),
                  onRefresh: () async {},
                  onLoadMore: () async {
                    if (useA) {
                      callA++;
                      await completerA.future;
                    } else {
                      callB++;
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final easyRefresh = tester.widget<EasyRefresh>(find.byType(EasyRefresh));
    final onLoad = easyRefresh.onLoad;
    expect(onLoad, isNotNull);
    final first = onLoad!.call();
    expect(callA, 1);

    container.read(useProviderA.notifier).set(false);
    await tester.pumpAndSettle();

    await triggerLoad(tester);
    expect(callB, 1);

    completerA.complete();
    await first;
  });
}
