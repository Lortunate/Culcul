import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:culcul/ui/widgets/smart_paging_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeFeedPagingShell<T> extends StatelessWidget {
  final double maxWidth;
  final AsyncValue<List<T>> asyncValue;
  final Widget skeleton;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoadMore;
  final int Function()? itemCount;
  final bool hasMore;
  final bool Function({required int previousCount, required int currentCount})?
  hasMoreAfterLoad;
  final EasyRefreshController? controller;
  final Widget Function(BuildContext context, List<T> items) builder;

  const HomeFeedPagingShell({
    super.key,
    required this.maxWidth,
    required this.asyncValue,
    required this.skeleton,
    required this.onRefresh,
    required this.builder,
    this.onLoadMore,
    this.itemCount,
    this.hasMore = true,
    this.hasMoreAfterLoad,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContentContainer(
      maxWidth: maxWidth,
      child: SmartPagingView<T>(
        asyncValue: asyncValue,
        controller: controller,
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        itemCount: itemCount,
        hasMore: hasMore,
        hasMoreAfterLoad: hasMoreAfterLoad,
        skeleton: skeleton,
        builder: builder,
      ),
    );
  }
}
