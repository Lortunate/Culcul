import 'package:culcul/data/models/live/index.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: _buildItem(context, history[index]),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, LiveDanmakuItem item) {
    if (item.dmType == 3) {
      return LiveSystemMessage(item: item);
    }

    if (item.nickname == t.live.danmaku.system_notice || item.nickname == '系统消息') {
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
