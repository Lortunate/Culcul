import 'dart:async';

import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/perf/dev_logger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';

class ScrollLoadTrigger {
  const ScrollLoadTrigger._();
  static int _sessionSeed = 0;

  static bool triggerOnScrollNotificationWithGate({
    required ScrollNotification notification,
    required double extentAfterThreshold,
    required PaginationLoadGate gate,
    required bool hasMore,
    bool isLoadingMore = false,
    required Future<void> Function() task,
    bool Function()? hasMoreAfter,
    required String source,
    int Function()? itemCount,
    bool onlyOnScrollEnd = true,
    double? viewportFactor,
    double maxThreshold = 1200,
  }) {
    var effectiveThreshold = extentAfterThreshold;
    if (viewportFactor != null) {
      final viewportBased = notification.metrics.viewportDimension * viewportFactor;
      final threshold = viewportBased > extentAfterThreshold
          ? viewportBased
          : extentAfterThreshold;
      effectiveThreshold = threshold > maxThreshold ? maxThreshold : threshold;
    }
    if (onlyOnScrollEnd && notification is! ScrollEndNotification) {
      return false;
    }
    if (notification.metrics.axis != Axis.vertical ||
        notification.metrics.extentAfter > effectiveThreshold) {
      return false;
    }

    unawaited(
      runWithGate(
        gate: gate,
        hasMore: hasMore,
        isLoadingMore: isLoadingMore,
        task: task,
        hasMoreAfter: hasMoreAfter,
        source: source,
        itemCount: itemCount,
      ),
    );
    return false;
  }

  static Future<IndicatorResult> runWithGate({
    required PaginationLoadGate gate,
    required bool hasMore,
    bool isLoadingMore = false,
    required Future<void> Function() task,
    bool Function()? hasMoreAfter,
    required String source,
    int Function()? itemCount,
  }) async {
    if (!hasMore || isLoadingMore) {
      return IndicatorResult.noMore;
    }

    final sessionId = '${DateTime.now().millisecondsSinceEpoch}_${++_sessionSeed}';
    final beforeItemCount = itemCount?.call();
    DevLogger.log('list', 'load_trigger', <String, Object?>{
      'source': source,
      'session_id': sessionId,
      'count': beforeItemCount,
    });

    final stopwatch = Stopwatch()..start();
    final result = await gate.run(
      hasMoreBefore: hasMore,
      task: task,
      hasMoreAfter: hasMoreAfter,
    );
    final afterItemCount = itemCount?.call();
    final itemsDelta = beforeItemCount == null || afterItemCount == null
        ? null
        : afterItemCount - beforeItemCount;

    DevLogger.log('list', 'load_complete', <String, Object?>{
      'source': source,
      'session_id': sessionId,
      'result': result.name,
      'elapsed_ms': stopwatch.elapsedMilliseconds,
      'count': afterItemCount,
      'items_delta': itemsDelta,
    });
    return result;
  }

  static Future<IndicatorResult> runWithNotifier({
    required PaginationLoadGate gate,
    required bool Function() hasMore,
    bool Function()? isLoadingMore,
    required Future<void> Function() loadMore,
    required String source,
    int Function()? itemCount,
  }) {
    final hasMoreNow = hasMore();
    return runWithGate(
      gate: gate,
      hasMore: hasMoreNow,
      isLoadingMore: isLoadingMore?.call() ?? false,
      task: loadMore,
      hasMoreAfter: hasMore,
      source: source,
      itemCount: itemCount,
    );
  }
}
