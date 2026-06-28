import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/data/pagination/pagination_load_gate.dart';
import 'package:culcul/core/data/pagination/scroll_load_trigger.dart';
import 'package:culcul/ui/widgets/feedback/app_empty_state_widget.dart';
import 'package:culcul/ui/widgets/feedback/app_error_widget.dart';
import 'package:culcul/ui/widgets/layout/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SmartPagingView<T> extends HookConsumerWidget {
  final AsyncValue<List<T>> asyncValue;
  final Widget Function(BuildContext context, List<T> items) builder;
  final Widget skeleton;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoadMore;
  final EasyRefreshController? controller;
  final bool hasMore;
  final int Function()? itemCount;
  final bool Function({required int previousCount, required int currentCount})?
  hasMoreAfterLoad;
  final Widget Function(BuildContext context, Object error, StackTrace? stackTrace)?
  errorBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;
  final String? emptyText;

  const SmartPagingView({
    super.key,
    required this.asyncValue,
    required this.builder,
    required this.skeleton,
    required this.onRefresh,
    this.onLoadMore,
    this.controller,
    this.hasMore = true,
    this.itemCount,
    this.hasMoreAfterLoad,
    this.errorBuilder,
    this.emptyBuilder,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshController = controller ?? useManagedEasyRefreshController();
    final loadGate = useMemoized(PaginationLoadGate.new, const []);
    useEffect(() {
      loadGate.reset();
      return null;
    }, [onLoadMore]);

    if (asyncValue.isLoading && !asyncValue.hasValue) {
      return KeyedSubtree(key: const ValueKey('paging_loading'), child: skeleton);
    }

    final items = asyncValue.value ?? <T>[];
    final Widget content;
    if (asyncValue.hasError && !asyncValue.hasValue) {
      content = CustomScrollView(
        key: const ValueKey('paging_error'),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child:
                  errorBuilder?.call(context, asyncValue.error!, asyncValue.stackTrace) ??
                  AppErrorWidget(
                    error: asyncValue.error!,
                    stackTrace: asyncValue.stackTrace,
                    onRetry: onRefresh,
                  ),
            ),
          ),
        ],
      );
    } else if (items.isEmpty) {
      content = CustomScrollView(
        key: const ValueKey('paging_empty'),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child:
                  emptyBuilder?.call(context) ??
                  AppEmptyStateWidget(
                    message: emptyText ?? t.common.no_content,
                    onAction: onRefresh,
                    actionLabel: t.common.retry,
                  ),
            ),
          ),
        ],
      );
    } else {
      content = builder(context, items);
    }

    return EasyRefresh(
      key: const ValueKey('paging_data'),
      controller: refreshController,
      header: const AppRefreshHeader(),
      footer: onLoadMore == null || !hasMore ? null : const AppLoadFooter(),
      onRefresh: () async {
        try {
          await onRefresh();
          return IndicatorResult.success;
        } catch (_) {
          return IndicatorResult.fail;
        }
      },
      onLoad: onLoadMore == null || !hasMore
          ? null
          : () {
              final previousCount = itemCount?.call() ?? items.length;
              return ScrollLoadTrigger.runWithGate(
                gate: loadGate,
                hasMore: hasMore,
                task: onLoadMore!,
                itemCount: itemCount,
                hasMoreAfter: () {
                  final currentCount = itemCount?.call();
                  final hasMoreAfterLoadCallback = hasMoreAfterLoad;
                  if (hasMoreAfterLoadCallback != null) {
                    return hasMoreAfterLoadCallback(
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
            },
      child: content,
    );
  }
}
