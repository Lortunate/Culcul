part of '../smart_paging_view.dart';

class _PagingContent<T> extends StatelessWidget {
  final AsyncValue<List<T>> asyncValue;
  final List<T> items;
  final Widget Function(BuildContext context, List<T> items) builder;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, Object error, StackTrace? stackTrace)?
  errorBuilder;
  final Widget Function(BuildContext context)? emptyBuilder;
  final String? emptyText;

  const _PagingContent({
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
            AppErrorWidget(
              message: emptyText ?? t.common.no_content,
              onRetry: onRefresh,
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
      slivers: [
        SliverFillRemaining(
          child: Center(child: child),
        ),
      ],
    );
  }
}
