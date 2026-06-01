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
    final content = _SmartPagingContent<T>(
      asyncValue: asyncValue,
      items: items,
      builder: builder,
      onRefresh: onRefresh,
      errorBuilder: errorBuilder,
      emptyBuilder: emptyBuilder,
      emptyText: emptyText,
    );

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
          : () => _handleLoadMore(
              items: items,
              onLoadMore: onLoadMore!,
              loadGate: loadGate,
              hasMore: hasMore,
              itemCount: itemCount,
              hasMoreAfterLoad: hasMoreAfterLoad,
            ),
      child: content,
    );
  }
}

class _SmartPagingContent<T> extends StatelessWidget {
  final AsyncValue<List<T>> asyncValue;
  final List<T> items;
  final Widget Function(BuildContext context, List<T> items) builder;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, Object error, StackTrace? stackTrace)?
  errorBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;
  final String? emptyText;

  const _SmartPagingContent({
    required this.asyncValue,
    required this.items,
    required this.builder,
    required this.onRefresh,
    required this.errorBuilder,
    required this.emptyBuilder,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    if (asyncValue.hasError && !asyncValue.hasValue) {
      return _PagingStatusView(
        key: const ValueKey('paging_error'),
        child:
            errorBuilder?.call(context, asyncValue.error!, asyncValue.stackTrace) ??
            AppErrorWidget(
              error: asyncValue.error!,
              stackTrace: asyncValue.stackTrace,
              onRetry: onRefresh,
            ),
      );
    }

    if (items.isEmpty) {
      return _PagingStatusView(
        key: const ValueKey('paging_empty'),
        child:
            emptyBuilder?.call(context) ??
            AppEmptyStateWidget(
              message: emptyText ?? t.common.no_content,
              onAction: onRefresh,
              actionLabel: t.common.retry,
            ),
      );
    }

    return builder(context, items);
  }
}

class _PagingStatusView extends StatelessWidget {
  final Widget child;

  const _PagingStatusView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [SliverFillRemaining(child: Center(child: child))],
    );
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
