import 'package:culcul/features/live/domain/entities/live_danmaku_item.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_gift_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_interact_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_normal_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_system_message.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/widgets.dart';

class LiveDanmakuMessageFactory {
  const LiveDanmakuMessageFactory();

  bool isSystemMessage(LiveDanmakuItem item) {
    return item.dmType == 3 || item.nickname == t.live.danmaku.system_notice;
  }

  Widget build(BuildContext context, LiveDanmakuItem item) {
    if (isSystemMessage(item)) {
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
