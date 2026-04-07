import 'dart:async';

import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScrollLoadTrigger', () {
    test('extentAfter threshold check works', () {
      final metrics = FixedScrollMetrics(
        minScrollExtent: 0,
        maxScrollExtent: 1000,
        pixels: 500,
        viewportDimension: 400,
        axisDirection: AxisDirection.down,
        devicePixelRatio: 1,
      );

      expect(
        ScrollLoadTrigger.shouldTriggerByExtentAfter(metrics, threshold: 120),
        isFalse,
      );
      expect(
        ScrollLoadTrigger.shouldTriggerByExtentAfter(metrics, threshold: 520),
        isTrue,
      );
    });

    test(
      'runWithGate returns noMore without running task when hasMore is false',
      () async {
        final gate = PaginationLoadGate();
        var called = false;

        final result = await ScrollLoadTrigger.runWithGate(
          gate: gate,
          hasMore: false,
          task: () async {
            called = true;
          },
          source: 'test.scroll',
        );

        expect(result, IndicatorResult.noMore);
        expect(called, isFalse);
      },
    );

    test('runWithGate guards concurrent calls through PaginationLoadGate', () async {
      final gate = PaginationLoadGate();
      final completer = Completer<void>();
      var callCount = 0;

      Future<void> task() async {
        callCount++;
        await completer.future;
      }

      final first = ScrollLoadTrigger.runWithGate(
        gate: gate,
        hasMore: true,
        task: task,
        source: 'test.scroll',
      );
      final second = ScrollLoadTrigger.runWithGate(
        gate: gate,
        hasMore: true,
        task: task,
        source: 'test.scroll',
      );

      expect(await second, IndicatorResult.success);
      completer.complete();
      expect(await first, IndicatorResult.success);
      expect(callCount, 1);
    });

    test('runWithGate returns fail when task throws', () async {
      final gate = PaginationLoadGate();

      final result = await ScrollLoadTrigger.runWithGate(
        gate: gate,
        hasMore: true,
        task: () async {
          throw Exception('boom');
        },
        source: 'test.scroll',
      );

      expect(result, IndicatorResult.fail);
    });

    test('runWithGate returns noMore when hasMoreAfter becomes false', () async {
      final gate = PaginationLoadGate();

      final result = await ScrollLoadTrigger.runWithGate(
        gate: gate,
        hasMore: true,
        task: () async {},
        hasMoreAfter: () => false,
        source: 'test.scroll',
      );

      expect(result, IndicatorResult.noMore);
    });

    test('runWithGate supports itemCount snapshots for perf logging payload', () async {
      final gate = PaginationLoadGate();
      var count = 2;

      final result = await ScrollLoadTrigger.runWithGate(
        gate: gate,
        hasMore: true,
        task: () async {
          count = 5;
        },
        itemCount: () => count,
        source: 'test.scroll',
      );

      expect(result, IndicatorResult.success);
      expect(count, 5);
    });

    test('runWithNotifier evaluates hasMore lazily and runs task', () async {
      final gate = PaginationLoadGate();
      var hasMore = true;
      var called = false;

      final result = await ScrollLoadTrigger.runWithNotifier(
        gate: gate,
        hasMore: () => hasMore,
        loadMore: () async {
          called = true;
          hasMore = false;
        },
        source: 'test.scroll.notifier',
      );

      expect(called, isTrue);
      expect(result, IndicatorResult.noMore);
    });

    test('runWithNotifier returns noMore when notifier reports no more', () async {
      final gate = PaginationLoadGate();
      var called = false;

      final result = await ScrollLoadTrigger.runWithNotifier(
        gate: gate,
        hasMore: () => false,
        loadMore: () async {
          called = true;
        },
        source: 'test.scroll.notifier',
      );

      expect(called, isFalse);
      expect(result, IndicatorResult.noMore);
    });
  });
}
