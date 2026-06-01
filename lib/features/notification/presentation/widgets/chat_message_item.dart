import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/ui/assemblies/text/bilibili_emoji_text.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/media/app_image_preview.dart';
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
      return _ChatSystemMessage(content: content);
    }

    if (message.type == PrivateMessageType.systemTip) {
      // System tip, such as follow restrictions
      final tips = message.systemTipTexts;
      if (tips != null && tips.isNotEmpty) {
        final text = tips.join();
        return _ChatSystemMessage(content: text);
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
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final cacheSize = (40 * dpr).round().clamp(1, 2048);

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
                  cacheWidth: cacheSize,
                  cacheHeight: cacheSize,
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
      return _ChatImageMessage(url: url, placeholderColor: bubbleColor);
    } else if (message.type == PrivateMessageType.text) {
      return _ChatBubble(
        isSelf: isSelf,
        color: bubbleColor,
        child: BilibiliEmojiText(
          text: message.textContent,
          emojiMap: emojiMap,
          style: TextStyle(color: textColor, fontSize: 16, height: 1.3),
          selectable: true,
          emojiSize: 24,
        ),
      );
    } else {
      String text = t.notification.chat.unsupported_type(type: message.type.value);
      if (message.titleText case final title?) {
        text += '\n$title';
      }
      return _ChatBubble(
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

class _ChatBubble extends StatelessWidget {
  final Widget child;
  final bool isSelf;
  final Color color;

  const _ChatBubble({required this.child, required this.isSelf, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CulculSpacing.sm, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: CulculRadius.radiusLg,
          topRight: CulculRadius.radiusLg,
          bottomLeft: isSelf ? CulculRadius.radiusLg : CulculRadius.radiusXs,
          bottomRight: isSelf ? CulculRadius.radiusXs : CulculRadius.radiusLg,
        ),
      ),
      child: child,
    );
  }
}

class _ChatImageMessage extends StatelessWidget {
  static const double _maxLogicalSize = 300;
  static const int _maxCacheDimension = 2048;

  final String url;
  final Color placeholderColor;

  const _ChatImageMessage({required this.url, required this.placeholderColor});

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final cacheSize = (_maxLogicalSize * pixelRatio).round().clamp(1, _maxCacheDimension);

    return GestureDetector(
      onTap: () => AppImagePreview.open(context, imageUrls: [url]),
      child: ExtendedImage.network(
        url,
        fit: BoxFit.cover,
        cacheWidth: cacheSize,
        cacheHeight: cacheSize,
        borderRadius: const BorderRadius.all(CulculRadius.radiusSm),
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.loading) {
            return Container(
              color: placeholderColor,
              width: 150,
              height: 150,
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }
          return null;
        },
      ),
    );
  }
}

class _ChatSystemMessage extends StatelessWidget {
  final String content;

  const _ChatSystemMessage({required this.content});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CulculSpacing.md,
          vertical: CulculSpacing.xxs + CulculSpacing.xxs / 2,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(CulculRadius.lg),
        ),
        child: Text(
          content,
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
