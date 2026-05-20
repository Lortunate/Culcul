part of 'notification_item_widget.dart';

class _NotificationItemContent extends StatelessWidget {
  final NotificationEntry item;
  final NotificationFeedType type;
  final NotificationNavigationParser navigationParser;

  const _NotificationItemContent({
    required this.item,
    required this.type,
    required this.navigationParser,
  });

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
          GestureDetector(
            onTap: () {
              if (user.mid != 0) {
                UserProfileRoute(mid: user.mid).push(context);
              }
            },
            child: AppAvatar(url: user.avatar, size: 40),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NotificationItemHeader(
                  nickname: user.nickname,
                  actionText: _getActionText(),
                  timeText: time.toSimpleDate(),
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
                _NotificationSourcePreview(
                  text: _getSourceText(detail),
                  imageUrl: detail.image,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleTap(BuildContext context, NotificationEntryDetail detail) async {
    final target = navigationParser.fromNotificationDetail(detail);
    final handled = await openNotificationNavigationTarget(context, target);
    if (handled || !context.mounted) return;

    context.showAppFeedback(
      t.notification.navigation_error(type: detail.type, id: detail.subjectId.toString()),
      level: AppFeedbackLevel.error,
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

class _NotificationItemHeader extends StatelessWidget {
  final String nickname;
  final String actionText;
  final String timeText;

  const _NotificationItemHeader({
    required this.nickname,
    required this.actionText,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            nickname,
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
          style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.outline),
        ),
        const SizedBox(width: 8),
        Text(
          timeText,
          style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
        ),
      ],
    );
  }
}

class _NotificationSourcePreview extends StatelessWidget {
  final String text;
  final String imageUrl;

  const _NotificationSourcePreview({required this.text, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (imageUrl.isNotEmpty) ...[
            const SizedBox(width: 8),
            AppNetworkImage(
              url: imageUrl,
              width: 40,
              height: 40,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ],
      ),
    );
  }
}
