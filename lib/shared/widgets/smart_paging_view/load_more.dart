part of '../smart_paging_view.dart';

Future<IndicatorResult> _handleRefresh(Future<void> Function() onRefresh) async {
  try {
    await onRefresh();
    return IndicatorResult.success;
  } catch (_) {
    return IndicatorResult.fail;
  }
}

Future<IndicatorResult> _handleLoadMore<T>({
  required List<T> items,
  required Future<void> Function() onLoadMore,
  required PaginationLoadGate loadGate,
  required bool hasMore,
  required int Function()? itemCount,
  required bool Function({required int previousCount, required int currentCount})?
  hasMoreAfterLoad,
}) async {
  final previousCount = itemCount?.call() ?? items.length;
  return ScrollLoadTrigger.runWithGate(
    gate: loadGate,
    hasMore: hasMore,
    task: onLoadMore,
    itemCount: itemCount,
    hasMoreAfter: () {
      final currentCount = itemCount?.call();
      if (hasMoreAfterLoad != null) {
        return hasMoreAfterLoad(
          previousCount: previousCount,
          currentCount: currentCount ?? previousCount,
        );
      }
      if (currentCount == null) {
        return true;
      }
      return currentCount > previousCount;
    },
    source: 'ui.smart_paging_view',
  );
}
