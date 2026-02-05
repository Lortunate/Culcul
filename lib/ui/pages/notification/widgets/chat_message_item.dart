import 'package:culcul/data/models/notification/private_message_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:culcul/ui/widgets/bilibili_emoji_text.dart';

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
    if (message.isWithdrawn) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '消息已撤回',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      );
    }

    if (message.msgType == 10) {
      // 系统通知
      final content = message.contentMap?['text'] as String? ?? '系统通知';
      return _buildSystemMessage(context, content);
    }

    if (message.msgType == 18) {
      // 系统提示 (e.g. 关注前限制)
      final tips = message.systemTipContent;
      if (tips != null && tips.isNotEmpty) {
        final text = tips.map((e) => e['text'] as String? ?? '').join('');
        return _buildSystemMessage(context, text);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: isSelf
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSelf) ...[_buildAvatar(avatarUrl), const SizedBox(width: 8)],
          Flexible(child: _buildBubble(context)),
          if (isSelf) ...[const SizedBox(width: 8), _buildAvatar(avatarUrl)],
        ],
      ),
    );
  }

  Widget _buildSystemMessage(BuildContext context, String content) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            content,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String url) {
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
                      return const Icon(Icons.person, color: Colors.grey);
                    }
                    return null;
                  },
                )
              : const Icon(Icons.person, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Bilibili Style: Self -> Pink (Primary), Other -> White/Surface
    final bubbleColor = isSelf
        ? colorScheme.primary
        : colorScheme.surfaceContainerLow;
    final textColor = isSelf ? colorScheme.onPrimary : colorScheme.onSurface;

    Widget content;

    if (message.msgType == 2 || message.msgType == 6) {
      // 图片
      final url = message.imageUrl;
      if (url == null) return const SizedBox();
      content = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                body: ExtendedImageGesturePageView.builder(
                  itemCount: 1,
                  controller: ExtendedPageController(),
                  itemBuilder: (BuildContext context, int index) {
                    return ExtendedImage.network(
                      url,
                      fit: BoxFit.contain,
                      cache: true,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) {
                        return GestureConfig(
                          minScale: 0.9,
                          animationMinScale: 0.7,
                          maxScale: 3.0,
                          animationMaxScale: 3.5,
                          speed: 1.0,
                          inertialSpeed: 100.0,
                          initialScale: 1.0,
                          inPageView: true,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ExtendedImage.network(
            url,
            fit: BoxFit.cover,
            cache: true,
            borderRadius: BorderRadius.circular(8),
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.loading) {
                return Container(
                  color: bubbleColor,
                  width: 150,
                  height: 150,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              return null;
            },
          ),
        ),
      );
    } else if (message.msgType == 1) {
      // 默认文本
      content = BilibiliEmojiText(
        text: message.textContent,
        emojiMap: emojiMap,
        style: TextStyle(color: textColor, fontSize: 16, height: 1.3),
        selectable: true,
        emojiSize: 24,
      );
    } else {
      // 未知类型
      String text = '[不支持的消息类型: ${message.msgType}]';
      if (message.contentMap != null) {
        if (message.contentMap!.containsKey('title')) {
          text += '\n${message.contentMap!['title']}';
        }
      }
      content = Text(
        text,
        style: TextStyle(
          color: textColor.withOpacity(0.7),
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isSelf ? 16 : 4),
          bottomRight: Radius.circular(isSelf ? 4 : 16),
        ),
      ),
      child: content,
    );
  }
}
