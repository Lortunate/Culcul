import 'package:culcul/features/live/models/live_models.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_gift_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_interact_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_normal_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_system_message.dart';
import 'package:flutter/material.dart';

class LiveDanmakuView extends StatelessWidget {
  final List<LiveDanmakuItem> history;
  final ScrollController? controller;

  const LiveDanmakuView({super.key, required this.history, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      reverse: true,
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: _isSystemMessage(item) ? 6 : 4),
          child: _buildItem(context, item),
        );
      },
    );
  }

  bool _isSystemMessage(LiveDanmakuItem item) {
    return item.dmType == 3 || item.nickname == t.live.danmaku.system_notice;
  }

  Widget _buildItem(BuildContext context, LiveDanmakuItem item) {
    if (_isSystemMessage(item)) {
      return LiveSystemMessage(item: item);
    }

    if (item.dmType == 1) {
      return LiveInteractMessage(item: item);
    }

    if (item.dmType == 2) {
      return LiveGiftMessage(item: item);
    }

    return LiveNormalMessage(item: item);
  }
}
