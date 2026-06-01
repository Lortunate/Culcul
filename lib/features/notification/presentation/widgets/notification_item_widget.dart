import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/notification/application/notification_navigation.dart';
import 'package:culcul/features/notification/domain/entities/notification_feed_type.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/notification/domain/entities/notification_entry.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';
import 'package:culcul/core/utils/format_extensions.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntry item;
  final NotificationFeedType type;
  final NotificationTargetOpener onOpenTarget;
  final ValueChanged<int> onOpenUser;
  static const NotificationNavigationParser _navigationParser =
      NotificationNavigationParser();

  const NotificationItemWidget({
    super.key,
    required this.item,
    required this.type,
    required this.onOpenTarget,
    required this.onOpenUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = item.primaryActor;
    final detail = item.detail;

    if (user == null) return const SizedBox.shrink();

    final time = DateTime.fromMillisecondsSinceEpoch(item.eventTime * 1000);
    final actionText = switch (type) {
      NotificationFeedType.like => t.notification.types.like,
      NotificationFeedType.at => t.notification.types.at,
      NotificationFeedType.reply => t.notification.types.reply,
      NotificationFeedType.system => t.notification.types.system,
    };
    final sourceText = detail.sourceContent.isNotEmpty
        ? detail.sourceContent
        : detail.title.isNotEmpty
        ? detail.title
        : t.notification.related_content;

    return InkWell(
      onTap: () => _handleTap(context, detail),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (user.mid != 0) {
                onOpenUser(user.mid);
              }
            },
            child: AppAvatar(url: user.avatar, size: 40),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      actionText,
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
                Container(
                  padding: const EdgeInsets.all(CulculSpacing.xs),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(CulculRadius.xs),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sourceText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (detail.image.isNotEmpty) ...[
                        const SizedBox(width: CulculSpacing.xs),
                        AppNetworkImage(
                          url: detail.image,
                          width: 40,
                          height: 40,
                          borderRadius: BorderRadius.circular(CulculRadius.xs),
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
    final handled = await onOpenTarget(target);
    if (handled || !context.mounted) return;

    context.showAppFeedback(
      t.notification.navigation_error(type: detail.type, id: detail.subjectId.toString()),
      level: AppFeedbackLevel.error,
    );
  }
}
