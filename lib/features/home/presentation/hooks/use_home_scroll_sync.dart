import 'package:culcul/features/home/presentation/view_models/home_tab_sync_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';

void useHomeScrollSync(
  WidgetRef ref,
  ScrollController scrollController,
  EasyRefreshController refreshController,
  int index,
) {
  ref.listen(homeTabSyncControllerProvider, (previous, next) {
    final didRetapCurrentTab =
        previous?.syncToken != next.syncToken && next.tabIndex == index;
    if (!didRetapCurrentTab || !scrollController.hasClients) {
      return;
    }

    if (scrollController.offset > 0) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }

    refreshController.callRefresh();
  });
}
