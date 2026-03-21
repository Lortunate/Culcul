import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_error_widget.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';

class SmartPagingView<T> extends HookConsumerWidget {
  final AsyncValue<List<T>> asyncValue;
  final Widget Function(BuildContext context, List<T> items) builder;
  final Widget skeleton;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoadMore;
  final dynamic provider;
  final EasyRefreshController? controller;
  final bool hasMore;
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
    this.provider,
    this.controller,
    this.hasMore = true,
    this.errorBuilder,
    this.emptyBuilder,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EasyRefreshController erController =
        controller ?? useMemoized(() => EasyRefreshController(), []);

    // 如果是首次加载且没有数据，显示骨架屏
    // 只有当是 Loading 状态 且 没有 value 时，才显示 Skeleton
    if (asyncValue.isLoading && !asyncValue.hasValue) {
      return KeyedSubtree(key: const ValueKey('paging_loading'), child: skeleton);
    }

    final items = asyncValue.value ?? [];
    Widget content;

    if (asyncValue.hasError && !asyncValue.hasValue) {
      // 错误状态
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
      // 空状态
      content = CustomScrollView(
        key: const ValueKey('paging_empty'),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Center(
              child:
                  emptyBuilder?.call(context) ??
                  AppErrorWidget(
                    message: emptyText ?? t.common.no_content,
                    onRetry: onRefresh,
                  ),
            ),
          ),
        ],
      );
    } else {
      // 数据状态
      content = builder(context, items);
    }

    return EasyRefresh(
      key: const ValueKey('paging_data'),
      controller: erController,
      header: AppRefreshHeader(),
      footer: onLoadMore == null || !hasMore ? null : AppLoadFooter(),
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
          : () async {
              // 记录当前的长度
              final prevCount = items.length;
              try {
                await onLoadMore!();

                // 如果 provider 存在，尝试智能检测
                if (provider != null) {
                  try {
                    dynamic newValue = ref.read(provider);
                    int nextCount = prevCount;
                    if (newValue is AsyncValue<List<T>>) {
                      nextCount = newValue.value?.length ?? prevCount;
                    } else if (newValue is AsyncValue) {
                      // 尝试作为 List 转换
                      final list = newValue.value;
                      if (list is List) {
                        nextCount = list.length;
                      }
                    }
                    if (nextCount > prevCount) {
                      return IndicatorResult.success;
                    }
                    return IndicatorResult.noMore;
                  } catch (e) {
                    debugPrint('SmartPagingView: Failed to read provider: $e');
                  }
                }

                // 如果没有 provider，或者读取失败，且没有报错，则认为成功。
                // 此时依赖外部传入的 hasMore 来控制下一次是否显示 footer。
                return IndicatorResult.success;
              } catch (_) {
                return IndicatorResult.fail;
              }
            },
      child: content,
    );
  }
}
