import 'package:culcul/ui/pages/home/home_events.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';

/// Listen to tab tap events to scroll to top or refresh.
///
/// If the list is scrolled down, it animates to the top.
/// If the list is already at the top, it triggers a refresh.
void useHomeScrollManager(
  WidgetRef ref,
  ScrollController scrollController,
  EasyRefreshController refreshController,
  int index,
) {
  ref.listen(homeTabTapProvider, (previous, next) {
    if (next?.index == index) {
      if (scrollController.hasClients) {
        if (scrollController.offset > 0) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          refreshController.callRefresh();
        }
      }
    }
  });
}
