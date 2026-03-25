import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_bubble.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_image_message.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_system_message.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_text_message.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatMessageItem extends StatelessWidget {
  final PrivateMessageDetail message;
  final bool isSelf;
  final String avatarUrl;
  final VoidCallback? onAvatarTap;
  final Map<String, String> emojiMap;

  const ChatMessageItem({
    super.key,
    required this.message,
    required this.isSelf,
    required this.avatarUrl,
    this.onAvatarTap,
    this.emojiMap = const {},
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (message.isWithdrawn) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            t.notification.chat.message_withdrawn,
            style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
          ),
        ),
      );
    }

    if (message.msgType == 10) {
      // 系统通知
      final content =
          message.contentMap?['text'] as String? ?? t.notification.types.system;
      return ChatSystemMessage(content: content);
    }

    if (message.msgType == 18) {
      // 系统提示 (e.g. 关注前限制)
      final tips = message.systemTipContent;
      if (tips != null && tips.isNotEmpty) {
        final text = tips.map((e) => e['text'] as String? ?? '').join('');
        return ChatSystemMessage(content: text);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSelf) ...[_buildAvatar(context, avatarUrl), const SizedBox(width: 8)],
          Flexible(child: _buildContent(context)),
          if (isSelf) ...[const SizedBox(width: 8), _buildAvatar(context, avatarUrl)],
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, String url) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onAvatarTap,
      child: ClipOval(
        child: SizedBox(
          width: 40,
          height: 40,
          child: url.isNotEmpty
              ? ExtendedImage.network(
                  url,
                  fit: BoxFit.cover,
                  cache: true,
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return Icon(Icons.person, color: colorScheme.onSurfaceVariant);
                    }
                    return null;
                  },
                )
              : Icon(Icons.person, color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bubbleColor = isSelf ? colorScheme.primary : colorScheme.surfaceContainerLow;
    final textColor = isSelf ? colorScheme.onPrimary : colorScheme.onSurface;

    if (message.msgType == 2 || message.msgType == 6) {
      final url = message.imageUrl;
      if (url == null) return const SizedBox();
      return ChatImageMessage(url: url, placeholderColor: bubbleColor);
    } else if (message.msgType == 1) {
      return ChatBubble(
        isSelf: isSelf,
        color: bubbleColor,
        child: ChatTextMessage(
          text: message.textContent,
          emojiMap: emojiMap,
          textColor: textColor,
        ),
      );
    } else {
      String text = t.notification.chat.unsupported_type(type: message.msgType);
      if (message.contentMap != null) {
        if (message.contentMap!.containsKey('title')) {
          text += '\\n${message.contentMap!['title']}';
        }
      }
      return ChatBubble(
        isSelf: isSelf,
        color: bubbleColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.7),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
  }
}
