import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_refresh/easy_refresh.dart';

class PagingListView<T> extends HookConsumerWidget {
  final AsyncValue<List<T>> asyncValue;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace stackTrace,
  )
  errorBuilder;
  final Widget loadingBuilder;
  final Widget? emptyBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext context, List<T> items)? containerBuilder;

  const PagingListView({
    super.key,
    required this.asyncValue,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.errorBuilder,
    required this.loadingBuilder,
    this.emptyBuilder,
    this.padding,
    this.physics,
    this.containerBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final scrollController = useScrollController();
    final erController = useMemoized(() => EasyRefreshController(), []);

    useEffect(() {
      void listener() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 500) {
          onLoadMore();
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    return EasyRefresh(
      controller: erController,
      header: const MaterialHeader(),
      footer: const MaterialFooter(),
      onRefresh: () async {
        await onRefresh();
        return IndicatorResult.success;
      },
      onLoad: () async {
        onLoadMore();
        return IndicatorResult.success;
      },
      child: asyncValue.when(
        data: (items) {
          if (items.isEmpty) {
            return emptyBuilder ??
                Center(
                  child: Text(
                    t.common.no_content,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                );
          }

          if (containerBuilder != null) {
            return SingleChildScrollView(
              controller: scrollController,
              physics: physics ?? const AlwaysScrollableScrollPhysics(),
              padding: padding,
              child: Column(
                children: [
                  containerBuilder!(context, items),
                  if (asyncValue.isLoading) const _BottomLoadingIndicator(),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: scrollController,
            physics: physics ?? const AlwaysScrollableScrollPhysics(),
            padding: padding,
            itemCount: items.length + (asyncValue.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == items.length) {
                return const _BottomLoadingIndicator();
              }
              return itemBuilder(context, items[index], index);
            },
          );
        },
        loading: () => loadingBuilder,
        error: (error, stackTrace) => errorBuilder(context, error, stackTrace),
      ),
    );
  }
}

class _BottomLoadingIndicator extends StatelessWidget {
  const _BottomLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
