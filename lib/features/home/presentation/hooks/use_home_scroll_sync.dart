import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef _HomeTabSyncEvent = ({int syncToken, int tabIndex});

final _homeTabSyncProvider = NotifierProvider<_HomeTabSyncController, _HomeTabSyncEvent>(
  _HomeTabSyncController.new,
);

class _HomeTabSyncController extends Notifier<_HomeTabSyncEvent> {
  @override
  _HomeTabSyncEvent build() => (syncToken: 0, tabIndex: 0);

  void onTabTapped(int index, {required bool isChanging}) {
    if (isChanging) {
      return;
    }
    state = (syncToken: state.syncToken + 1, tabIndex: index);
  }
}

void notifyHomeTabTapped(WidgetRef ref, int index, {required bool isChanging}) {
  ref.read(_homeTabSyncProvider.notifier).onTabTapped(index, isChanging: isChanging);
}

void useHomeScrollSync(
  WidgetRef ref,
  ScrollController scrollController,
  EasyRefreshController refreshController,
  int index,
) {
  ref.listen(_homeTabSyncProvider, (previous, next) {
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
