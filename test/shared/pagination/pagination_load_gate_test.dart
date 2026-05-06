import 'dart:async';

import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns noMore and does not execute task when hasMoreBefore is false', () async {
    final gate = PaginationLoadGate();
    var called = false;

    final result = await gate.run(
      hasMoreBefore: false,
      task: () async {
        called = true;
      },
    );

    expect(result, IndicatorResult.noMore);
    expect(called, isFalse);
  });

  test('concurrent calls only execute the task once', () async {
    final gate = PaginationLoadGate();
    final completer = Completer<void>();
    var callCount = 0;

    final first = gate.run(
      hasMoreBefore: true,
      task: () async {
        callCount++;
        await completer.future;
      },
    );
    final second = gate.run(
      hasMoreBefore: true,
      task: () async {
        callCount++;
      },
    );

    final secondResult = await second;
    expect(secondResult, IndicatorResult.success);
    expect(callCount, 1);

    completer.complete();
    final firstResult = await first;
    expect(firstResult, IndicatorResult.success);
    expect(callCount, 1);
  });

  test('returns fail when task throws', () async {
    final gate = PaginationLoadGate();

    final result = await gate.run(
      hasMoreBefore: true,
      task: () async {
        throw Exception('load failed');
      },
    );

    expect(result, IndicatorResult.fail);
  });

  test('returns noMore when hasMoreAfter is false', () async {
    final gate = PaginationLoadGate();

    final result = await gate.run(
      hasMoreBefore: true,
      task: () async {},
      hasMoreAfter: () => false,
    );

    expect(result, IndicatorResult.noMore);
  });

  test('reset clears inFlight so next context can run immediately', () async {
    final gate = PaginationLoadGate();
    final completer = Completer<void>();
    var callCount = 0;

    final first = gate.run(
      hasMoreBefore: true,
      task: () async {
        callCount++;
        await completer.future;
      },
    );

    gate.reset();

    final second = await gate.run(
      hasMoreBefore: true,
      task: () async {
        callCount++;
      },
    );
    expect(second, IndicatorResult.success);
    expect(callCount, 2);

    completer.complete();
    final firstResult = await first;
    expect(firstResult, IndicatorResult.success);
  });

  test('supports different hasMore values before and after task', () async {
    final gate = PaginationLoadGate();
    var hasMore = true;

    final result = await gate.run(
      hasMoreBefore: hasMore,
      task: () async {
        hasMore = false;
      },
      hasMoreAfter: () => hasMore,
    );

    expect(result, IndicatorResult.noMore);
  });
}
