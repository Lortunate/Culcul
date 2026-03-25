import 'package:culcul/features/home/presentation/home_events.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_refresh/easy_refresh.dart';

void useHomeScrollController(
  WidgetRef ref,
  ScrollController scrollController,
  EasyRefreshController refreshController,
  int index,
) {
  ref.listen(homeTabTapProvider, (previous, next) {
    if (next?.index != index || !scrollController.hasClients) {
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

