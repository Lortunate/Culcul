import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/hooks/use_managed_easy_refresh_controller.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:culcul/core/pagination/scroll_load_trigger.dart';
import 'package:culcul/shared/widgets/app_empty_state_widget.dart';
import 'package:culcul/shared/widgets/app_error_widget.dart';
import 'package:culcul/shared/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'smart_paging_view/content.dart';
part 'smart_paging_view/load_more.dart';

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
    final content = _PagingContent(
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
      header: AppRefreshHeader(),
      footer: onLoadMore == null || !hasMore ? null : AppLoadFooter(),
      onRefresh: () => _handleRefresh(onRefresh),
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
