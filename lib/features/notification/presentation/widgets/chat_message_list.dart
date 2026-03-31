import 'package:culcul/i18n/i18n.dart';
import 'package:culcul/core/pagination/paged_list_state.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_message_item.dart';
import 'package:culcul/features/notification/presentation/widgets/chat_time_divider.dart';
import 'package:culcul/ui/widgets/refresh_header_footer.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatefulWidget {
  final PagedListState<PrivateMessage> paging;
  final Map<String, String> emojiMap;
  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;
  final int currentUserId;
  final String selfAvatarUrl;
  final String otherAvatarUrl;
  final ScrollController? scrollController;

  const ChatMessageList({
    super.key,
    required this.paging,
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
    final t = i18n(context);
    final messages = widget.paging.items;
    if (messages.isEmpty) {
      return EasyRefresh(
        onRefresh: widget.onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(child: Text(t.notification.chat.no_message)),
              ),
            );
          },
        ),
      );
    }

    return EasyRefresh(
      onRefresh: widget.onRefresh,
      onLoad: widget.paging.hasMore ? widget.onLoadMore : null,
      header: null,
      footer: AppLoadFooter(),
      child: ListView.separated(
        controller: widget.scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: messages.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final message = messages[index];
          final isSelf = message.isMe(widget.currentUserId);

          bool showTime = false;
          if (index == messages.length - 1) {
            showTime = true;
          } else {
            final nextMessage = messages[index + 1];
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
                      SnackBar(
                        content: Text(t.notification.chat.page_not_developed),
                        duration: const Duration(seconds: 1),
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
