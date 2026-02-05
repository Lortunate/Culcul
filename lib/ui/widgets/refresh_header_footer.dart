import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// 统一的下拉刷新 Header
class AppRefreshHeader extends ClassicHeader {
  const AppRefreshHeader({super.key})
      : super(
          dragText: '下拉刷新',
          armedText: '释放刷新',
          readyText: '正在刷新...',
          processingText: '正在刷新...',
          processedText: '刷新完成',
          noMoreText: '没有更多了',
          failedText: '刷新失败',
          messageText: '最后更新于 %T',
          showMessage: false,
          showText: false, // 默认不显示文字，追求简洁
          iconTheme: const IconThemeData(color: Colors.pink), // 主题色图标
        );
}

/// 统一的上拉加载 Footer
class AppLoadFooter extends ClassicFooter {
  const AppLoadFooter({super.key})
      : super(
          dragText: '上拉加载',
          armedText: '释放加载',
          readyText: '正在加载...',
          processingText: '正在加载...',
          processedText: '加载完成',
          noMoreText: '没有更多了',
          failedText: '加载失败',
          messageText: '最后更新于 %T',
          showMessage: false,
          showText: true, // 加载更多保留文字提示
          iconTheme: const IconThemeData(color: Colors.pink),
        );
}
