import 'package:culcul/i18n/strings.g.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// 统一的下拉刷新 Header
class AppRefreshHeader extends ClassicHeader {
  AppRefreshHeader({super.key})
    : super(
        dragText: t.common.pull_down_to_refresh,
        armedText: t.common.release_to_refresh,
        readyText: t.common.loading,
        processingText: t.common.loading,
        processedText: t.common.refresh_completed,
        noMoreText: t.common.no_more_content,
        failedText: t.common.refresh_failed,
        messageText: 'Last updated at %T',
        showMessage: false,
        showText: false, // 默认不显示文字，追求简洁
        iconTheme: const IconThemeData(color: Colors.pink), // 主题色图标
      );
}

/// 统一的上拉加载 Footer
class AppLoadFooter extends ClassicFooter {
  AppLoadFooter({super.key})
    : super(
        dragText: t.common.pull_up_to_load_more,
        armedText: t.common.release_to_load_more,
        readyText: t.common.loading,
        processingText: t.common.loading,
        processedText: t.common.load_completed,
        noMoreText: t.common.no_more_content,
        failedText: t.common.load_failed,
        messageText: 'Last updated at %T',
        showMessage: false,
        showText: true, // 加载更多保留文字提示
        iconTheme: const IconThemeData(color: Colors.pink),
      );
}
