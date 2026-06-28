import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/models/private_message.dart';
import 'package:culcul/ui/widgets/text/bilibili_emoji_text.dart';
import 'package:culcul/core/theme/culcul_tokens.dart';
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
    Widget buildSystemMessage(String content) {
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
      return buildSystemMessage(content);
    }

    if (message.type == PrivateMessageType.systemTip) {
      // System tip, such as follow restrictions
      final tips = message.systemTipTexts;
      if (tips != null && tips.isNotEmpty) {
        final text = tips.join();
        return buildSystemMessage(text);
      }
    }

    final dpr = MediaQuery.devicePixelRatioOf(context);
    final avatarCacheSize = (40 * dpr).round().clamp(1, 2048);
    final avatar = GestureDetector(
      onTap: onAvatarTap,
      child: ClipOval(
        child: SizedBox(
          width: 40,
          height: 40,
          child: avatarUrl.isNotEmpty
              ? ExtendedImage.network(
                  avatarUrl,
                  fit: BoxFit.cover,
                  cacheWidth: avatarCacheSize,
                  cacheHeight: avatarCacheSize,
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

    final bubbleColor = isSelf ? colorScheme.primary : colorScheme.surfaceContainerLow;
    final textColor = isSelf ? colorScheme.onPrimary : colorScheme.onSurface;
    const bubblePadding = EdgeInsets.symmetric(
      horizontal: CulculSpacing.sm,
      vertical: 10,
    );
    final bubbleDecoration = BoxDecoration(
      color: bubbleColor,
      borderRadius: BorderRadius.only(
        topLeft: CulculRadius.radiusLg,
        topRight: CulculRadius.radiusLg,
        bottomLeft: isSelf ? CulculRadius.radiusLg : CulculRadius.radiusXs,
        bottomRight: isSelf ? CulculRadius.radiusXs : CulculRadius.radiusLg,
      ),
    );
    final Widget content;
    if (message.type.isImage) {
      final url = message.imageUrl;
      if (url == null) {
        content = const SizedBox();
      } else {
        const maxLogicalImageSize = 300.0;
        const maxImageCacheDimension = 2048;
        final imageCacheSize = (maxLogicalImageSize * dpr).round().clamp(
          1,
          maxImageCacheDimension,
        );
        content = GestureDetector(
          onTap: () => AppImagePreview.open(context, imageUrls: [url]),
          child: ExtendedImage.network(
            url,
            fit: BoxFit.cover,
            cacheWidth: imageCacheSize,
            cacheHeight: imageCacheSize,
            borderRadius: const BorderRadius.all(CulculRadius.radiusSm),
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.loading) {
                return Container(
                  color: bubbleColor,
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
    } else if (message.type == PrivateMessageType.text) {
      content = Container(
        padding: bubblePadding,
        decoration: bubbleDecoration,
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
      content = Container(
        padding: bubblePadding,
        decoration: bubbleDecoration,
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

    return Row(
      mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSelf) ...[avatar, const SizedBox(width: 8)],
        Flexible(child: content),
        if (isSelf) ...[const SizedBox(width: 8), avatar],
      ],
    );
  }
}
