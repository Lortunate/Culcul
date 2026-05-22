part of 'user_profile_info.dart';

class _StatsRow extends StatelessWidget {
  final ProfileUser user;
  final bool isSelf;
  final double avatarSize;

  const _StatsRow({required this.user, required this.isSelf, required this.avatarSize});

  @override
  Widget build(BuildContext context) {
    final navigation = ProfileNavigationScope.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: avatarSize + 12),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UserProfileStatItem(
                      count: user.followingCount,
                      label: t.profile.stats.following,
                      onTap: () => navigation.onOpenFollowings(int.parse(user.id)),
                    ),
                    UserProfileStatItem(
                      count: user.followersCount,
                      label: t.profile.stats.followers,
                      onTap: () => navigation.onOpenFollowers(int.parse(user.id)),
                    ),
                    UserProfileStatItem(
                      count: user.likesCount,
                      label: t.profile.stats.likes,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                UserProfileButtons(profile: user, isSelf: isSelf),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserIdentity extends StatelessWidget {
  final ProfileUser user;

  const _UserIdentity({required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Flexible(
          child: Text(
            user.username,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        if (user.vipStatus == 1) ...[
          VipTag(type: user.vipType),
          const SizedBox(width: 6),
        ],
        LevelTag(level: user.level),
      ],
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(Icons.verified_rounded, size: 16, color: colorScheme.primary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              t.profile.verified_badge,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _UidTag extends StatelessWidget {
  final String uid;

  const _UidTag({required this.uid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'UID: $uid',
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _BioSection extends StatelessWidget {
  final String bio;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _BioSection({
    required this.bio,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: onToggle,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                bio,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
                maxLines: isExpanded ? null : 1,
                overflow: isExpanded ? null : TextOverflow.ellipsis,
              ),
            ),
            if (bio.length > 20)
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 2),
                child: Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 16,
                  color: colorScheme.outline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
