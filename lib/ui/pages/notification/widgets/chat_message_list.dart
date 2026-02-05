import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/ui/pages/notification/widgets/chat_message_item.dart';
import 'package:culcul/ui/pages/notification/widgets/chat_time_divider.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatefulWidget {
  final List<PrivateMessageDetail> messages;
  final Map<String, String> emojiMap;
  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;
  final int currentUserId;
  final String selfAvatarUrl;
  final String otherAvatarUrl;
  final ScrollController? scrollController;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.emojiMap,
    required this.onLoadMore,
    this.onRefresh,
    required this.currentUserId,
    required this.selfAvatarUrl,
    required this.otherAvatarUrl,
    this.scrollController,
  });

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  @override
  Widget build(BuildContext context) {
    if (widget.messages.isEmpty) {
      return EasyRefresh(
        onRefresh: widget.onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: const Center(child: Text('暂无消息')),
              ),
            );
          },
        ),
      );
    }

    return EasyRefresh(
      onRefresh: widget.onRefresh,
      onLoad: widget.onLoadMore,
      header: null,
      footer: const ClassicFooter(
        dragText: '下拉加载更多',
        armedText: '释放加载',
        readyText: '加载中...',
        processingText: '加载中...',
        processedText: '加载完成',
        noMoreText: '没有更多了',
        failedText: '加载失败',
        messageText: '最后更新于 %T',
      ),
      child: ListView.builder(
        controller: widget.scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          final message = widget.messages[index];
          final isSelf = message.isMe(widget.currentUserId);

          bool showTime = false;
          if (index == widget.messages.length - 1) {
            showTime = true;
          } else {
            final nextMessage = widget.messages[index + 1];
            if (message.timestamp - nextMessage.timestamp > 300) {
              showTime = true;
            }
          }

          return Column(
            children: [
              if (showTime) ChatTimeDivider(timestamp: message.timestamp),
              ChatMessageItem(
                message: message,
                isSelf: isSelf,
                avatarUrl: isSelf ? widget.selfAvatarUrl : widget.otherAvatarUrl,
                emojiMap: widget.emojiMap,
                onAvatarTap: () {
                  if (!isSelf) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('用户详情页暂未开发'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
