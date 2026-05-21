import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_danmaku_message_factory.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_danmaku_tokens.dart';
import 'package:flutter/material.dart';

class LiveDanmakuView extends StatelessWidget {
  final List<LiveDanmakuItem> history;
  final ScrollController? controller;
  final LiveDanmakuMessageFactory _messageFactory = const LiveDanmakuMessageFactory();

  const LiveDanmakuView({super.key, required this.history, this.controller});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ListView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        padding: LiveDanmakuTokens.listPadding,
        reverse: true,
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          final padding = _messageFactory.isSystemMessage(item)
              ? LiveDanmakuTokens.systemItemPadding
              : LiveDanmakuTokens.normalItemPadding;

          return RepaintBoundary(
            child: Padding(padding: padding, child: _messageFactory.build(context, item)),
          );
        },
      ),
    );
  }
}
