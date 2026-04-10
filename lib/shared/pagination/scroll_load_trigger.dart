import 'dart:async';

import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:culcul/shared/perf/list_perf_logger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';

class ScrollLoadTrigger {
  const ScrollLoadTrigger._();
  static int _sessionSeed = 0;

  static double resolveExtentAfterThreshold(
    ScrollMetrics metrics, {
    required double minThreshold,
    double viewportFactor = 1.0,
    double maxThreshold = 1200,
  }) {
    final viewportBased = metrics.viewportDimension * viewportFactor;
    final threshold = viewportBased > minThreshold ? viewportBased : minThreshold;
    return threshold > maxThreshold ? maxThreshold : threshold;
  }

  static bool shouldTriggerByExtentAfter(
    ScrollMetrics metrics, {
    required double threshold,
  }) {
    if (metrics.axis != Axis.vertical) {
      return false;
    }
    return metrics.extentAfter <= threshold;
  }

  static bool shouldTriggerOnScrollNotification(
    ScrollNotification notification, {
    required double extentAfterThreshold,
    bool onlyOnScrollEnd = true,
  }) {
    if (onlyOnScrollEnd && notification is! ScrollEndNotification) {
      return false;
    }
    return shouldTriggerByExtentAfter(
      notification.metrics,
      threshold: extentAfterThreshold,
    );
  }

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
    final effectiveThreshold = viewportFactor == null
        ? extentAfterThreshold
        : resolveExtentAfterThreshold(
            notification.metrics,
            minThreshold: extentAfterThreshold,
            viewportFactor: viewportFactor,
            maxThreshold: maxThreshold,
          );
    if (!shouldTriggerOnScrollNotification(
      notification,
      extentAfterThreshold: effectiveThreshold,
      onlyOnScrollEnd: onlyOnScrollEnd,
    )) {
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
    ListPerfLogger.log(
      ListPerfEvent.loadTrigger,
      fields: <String, Object?>{
        'source': source,
        'session_id': sessionId,
        'count': beforeItemCount,
      },
    );

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

    ListPerfLogger.log(
      ListPerfEvent.loadComplete,
      fields: <String, Object?>{
        'source': source,
        'session_id': sessionId,
        'result': result.name,
        'elapsed_ms': stopwatch.elapsedMilliseconds,
        'count': afterItemCount,
        'items_delta': itemsDelta,
      },
    );
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
