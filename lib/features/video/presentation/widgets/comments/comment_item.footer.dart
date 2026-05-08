part of 'comment_item.dart';

class _Footer extends StatelessWidget {
  final CommentItem item;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onReply;

  const _Footer({required this.item, this.onLike, this.onDislike, this.onReply});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLiked = item.action == 1;

    return Row(
      children: [
        Text(
          FormatUtils.formatTimeAgo(item.ctime),
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        if (item.content.device.isNotEmpty) ...[
          const SizedBox(width: 12),
          Text(
            item.content.device,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const Spacer(),
        _Action(
          icon: isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
          color: isLiked ? colorScheme.primary : null,
          label: item.like > 0 ? FormatUtils.formatNumber(item.like) : '',
          onTap: onLike,
        ),
        const SizedBox(width: 16),
        _Action(icon: Icons.thumb_down_outlined, label: '', onTap: onDislike),
        const SizedBox(width: 16),
        _Action(icon: Icons.chat_bubble_outline_rounded, label: '', onTap: onReply),
        const SizedBox(width: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AppClickable(
            onTap: () {},
            child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.more_vert_rounded,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _Action({required this.icon, required this.label, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contentColor = color ?? theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: contentColor),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: contentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
