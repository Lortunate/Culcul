import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_bubble.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_image_message.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_system_message.dart';
import 'package:culcul/features/notification/presentation/widgets/chat/chat_text_message.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatMessageItem extends StatelessWidget {
  final PrivateMessage message;
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
        child: Text(
          t.notification.chat.message_withdrawn,
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
        ),
      );
    }

    if (message.type == PrivateMessageType.notice) {
      // System notice
      final content = message.primaryText ?? t.notification.types.system;
      return ChatSystemMessage(content: content);
    }

    if (message.type == PrivateMessageType.systemTip) {
      // System tip, such as follow restrictions
      final tips = message.systemTipTexts;
      if (tips != null && tips.isNotEmpty) {
        final text = tips.join('');
        return ChatSystemMessage(content: text);
      }
    }

    return Row(
      mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSelf) ...[_buildAvatar(context, avatarUrl), const SizedBox(width: 8)],
        Flexible(child: _buildContent(context)),
        if (isSelf) ...[const SizedBox(width: 8), _buildAvatar(context, avatarUrl)],
      ],
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

    if (message.type.isImage) {
      final url = message.imageUrl;
      if (url == null) return const SizedBox();
      return ChatImageMessage(url: url, placeholderColor: bubbleColor);
    } else if (message.type == PrivateMessageType.text) {
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
      String text = t.notification.chat.unsupported_type(type: message.type.value);
      if (message.titleText case final title?) {
        text += '\n$title';
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
