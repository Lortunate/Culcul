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

  const SmartPagingView({
    super.key,
    required this.asyncValue,
    required this.builder,
    required this.skeleton,
    required this.onRefresh,
    this.onLoadMore,
    required this.provider,
    this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final EasyRefreshController erController =
        controller ?? useMemoized(() => EasyRefreshController(), []);

    // 如果是首次加载且没有数据，显示骨架屏
    // 只有当是 Loading 状态 且 没有 value 时，才显示 Skeleton
    if (asyncValue.isLoading && !asyncValue.hasValue) {
      return KeyedSubtree(
        key: const ValueKey('paging_loading'),
        child: skeleton,
      );
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
              child: AppErrorWidget(
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
              child: AppErrorWidget(message: t.common.no_content, onRetry: onRefresh),
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
      footer: onLoadMore == null ? null : AppLoadFooter(),
      onRefresh: () async {
        try {
          await onRefresh();
          return IndicatorResult.success;
        } catch (_) {
          return IndicatorResult.fail;
        }
      },
      onLoad: onLoadMore == null
          ? null
          : () async {
              // 使用 .value 避免在 Loading 状态下读取 value 抛出异常（尽管通常不会）
              // 如果 provider 是 dynamic，我们需要小心。
              // 这里假设 provider 是一个可以被 ref.read 读取并返回 AsyncValue 的对象。
              // 为了稳健性，我们直接比较当前的 items 长度和加载后的 items 长度。
              // 但是我们需要访问 provider 的最新状态。
              // 由于 loadMore 是 async 的，await 之后，asyncValue 可能还没更新（因为 SmartPagingView 还没 rebuild）
              // 或者已经更新了。

              // 更好的做法：记录当前的长度
              final prevCount = items.length;
              try {
                await onLoadMore!();
                // 读取最新的 provider 状态
                // 注意：ref.read(provider) 可能会报错如果 provider 类型不对。
                // 我们可以尝试通过 ref.read(provider) 获取。
                // 如果 provider 是 AsyncNotifierProvider, ref.read(provider) 返回 AsyncValue。

                // 如果无法直接读取 provider，我们可以依赖 asyncValue 的更新吗？
                // onLoad 是 async 的。EasyRefresh 会等待它返回。
                // 但是 asyncValue 是 build 方法的参数，不会自动更新。
                // 我们需要 ref.read(provider) 来获取最新值。

                dynamic newValue;
                try {
                  newValue = ref.read(provider);
                } catch (e) {
                  debugPrint('SmartPagingView: Failed to read provider: $e');
                }

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
              } catch (_) {
                return IndicatorResult.fail;
              }
            },
      child: content,
    );
  }
}
