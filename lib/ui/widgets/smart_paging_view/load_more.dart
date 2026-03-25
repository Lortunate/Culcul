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
  required WidgetRef ref,
  required List<T> items,
  required Future<void> Function() onLoadMore,
  required dynamic provider,
}) async {
  final previousCount = items.length;

  try {
    await onLoadMore();

    final nextCount = _readItemCount<T>(ref: ref, provider: provider);
    if (nextCount == null) {
      return IndicatorResult.success;
    }

    return nextCount > previousCount ? IndicatorResult.success : IndicatorResult.noMore;
  } catch (_) {
    return IndicatorResult.fail;
  }
}

int? _readItemCount<T>({required WidgetRef ref, required dynamic provider}) {
  if (provider == null) {
    return null;
  }

  try {
    final newValue = ref.read(provider);
    if (newValue is AsyncValue<List<T>>) {
      return newValue.value?.length;
    }
    if (newValue is AsyncValue) {
      final value = newValue.value;
      if (value is List) {
        return value.length;
      }
    }
  } catch (error) {
    debugPrint('SmartPagingView: Failed to read provider: $error');
  }

  return null;
}
