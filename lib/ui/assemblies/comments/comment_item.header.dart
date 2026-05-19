part of 'comment_item.dart';

class _Header extends StatelessWidget {
  final CommentMember member;
  final int? upperMid;

  const _Header({required this.member, this.upperMid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    final isVip = member.vip.vipStatus == 1;
    final isUpper = upperMid != null && member.mid == upperMid.toString();

    return Row(
      children: [
        Flexible(
          child: Text(
            member.uname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isVip ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: 6),
        if (member.levelInfo.currentLevel > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: LevelTag(level: member.levelInfo.currentLevel),
          ),
        if (isUpper)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0.5),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              t.common.up,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 9,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
