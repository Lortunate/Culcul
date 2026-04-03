import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/features/notification/presentation/utils/notification_navigation.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:culcul/core/utils/format_extensions.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntry item;
  final NotificationFeedType type;
  static const NotificationNavigationParser _navigationParser =
      NotificationNavigationParser();

  const NotificationItemWidget({super.key, required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = item.primaryActor;
    final detail = item.detail;

    if (user == null) return const SizedBox.shrink();

    final time = DateTime.fromMillisecondsSinceEpoch(item.eventTime * 1000);

    return InkWell(
      onTap: () => _handleTap(context, detail),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          GestureDetector(
            onTap: () {
              if (user.mid != 0) {
                UserProfileRoute(mid: user.mid).push(context);
              }
            },
            child: AppAvatar(url: user.avatar, size: 40),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Name + Action + Time
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.nickname,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getActionText(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time.toSimpleDate(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Main Content (Reply message or "Liked your comment")
                if (type != NotificationFeedType.like) ...[
                  Text(
                    detail.message.isNotEmpty
                        ? detail.message
                        : detail.targetReplyContent,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                ],
                // Source/Quote Context
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getSourceText(detail),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (detail.image.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: AppNetworkImage(
                            url: detail.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleTap(BuildContext context, NotificationEntryDetail detail) async {
    final target = _navigationParser.fromNotificationDetail(detail);
    final handled = await openNotificationNavigationTarget(context, target);
    if (handled || !context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          t.notification.navigation_error(
            type: detail.type,
            id: detail.subjectId.toString(),
          ),
        ),
      ),
    );
  }

  String _getActionText() {
    switch (type) {
      case NotificationFeedType.like:
        return t.notification.types.like;
      case NotificationFeedType.at:
        return t.notification.types.at;
      case NotificationFeedType.reply:
        return t.notification.types.reply;
      case NotificationFeedType.system:
        return t.notification.types.system;
    }
  }

  String _getSourceText(NotificationEntryDetail detail) {
    if (detail.sourceContent.isNotEmpty) {
      return detail.sourceContent;
    }
    if (detail.title.isNotEmpty) {
      return detail.title;
    }
    return t.notification.related_content;
  }
}
