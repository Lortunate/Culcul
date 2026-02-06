import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/domain/entities/user_profile.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/user_space/user_space_provider.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileHeader extends ConsumerWidget {
  final UserProfile? profile;

  const UserProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      stretch: true,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // TODO: More actions (Report, Block, etc.)
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Container(
          color: colorScheme.surface,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Avatar
                      Hero(
                        tag: 'user_avatar_${profile?.id}',
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: profile?.vipStatus == 1
                                  ? const Color(0xFFFB7299)
                                  : colorScheme.surface,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.shadow.withValues(alpha: 0.1),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: AppAvatar(
                            url: profile?.avatarUrl,
                            size: 76,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Follow & Message Buttons
                      if (profile != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilledButton.tonal(
                              onPressed: () {
                                ChatRoute(talkerId: int.parse(profile!.id))
                                    .push(context);
                              },
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: const Text('私信'),
                            ),
                            const SizedBox(width: 8),
                            FollowButton(
                              isFollowed: profile!.isFollowing,
                              onTap: () {
                                ref
                                    .read(
                                      userSpaceProvider(profile!.id).notifier,
                                    )
                                    .toggleFollow();
                              },
                              width: 80,
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Name & VIP
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          profile?.username ?? '',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: (profile?.vipStatus == 1)
                                ? const Color(0xFFFB7299)
                                : colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (profile?.vipStatus == 1) ...[
                        const SizedBox(width: 6),
                        _VipTag(type: profile!.vipType),
                      ],
                      const SizedBox(width: 6),
                      if (profile != null) _LevelTag(level: profile!.level),
                    ],
                  ),
                  if (profile?.bio != null && profile!.bio!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      profile!.bio!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  // Stats
                  if (profile != null)
                    Row(
                      children: [
                        _StatText(
                          count: profile!.followingCount,
                          label: t.profile.stats.following,
                          onTap: () => FollowingsRoute(
                            vmid: int.parse(profile!.id),
                          ).push(context),
                        ),
                        const SizedBox(width: 24),
                        _StatText(
                          count: profile!.followersCount,
                          label: t.profile.stats.followers,
                          onTap: () => FollowersRoute(
                            vmid: int.parse(profile!.id),
                          ).push(context),
                        ),
                        const SizedBox(width: 24),
                        _StatText(
                          count: profile!.likesCount,
                          label: '获赞',
                        ),
                      ],
                    ),
                ],
              ),
            ),
      ),
    );
  }
}

class _StatText extends StatelessWidget {
  final int count;
  final String label;
  final VoidCallback? onTap;

  const _StatText({
    required this.count,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            FormatUtils.formatNumber(count),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

// Duplicated from ProfileAppBar for now
class _VipTag extends StatelessWidget {
  final int type;
  const _VipTag({required this.type});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isYear = type == 2;
    final color = const Color(0xFFFB7299);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isYear ? t.profile.vip.annual_premium : t.profile.vip.premium,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.1,
        ),
      ),
    );
  }
}

class _LevelTag extends StatelessWidget {
  final int level;
  const _LevelTag({required this.level});

  @override
  Widget build(BuildContext context) {
    final Color levelColor;
    switch (level) {
      case 0:
      case 1:
        levelColor = const Color(0xFFBFBFBF);
        break;
      case 2:
        levelColor = const Color(0xFF95DDB2);
        break;
      case 3:
        levelColor = const Color(0xFF92D1E5);
        break;
      case 4:
        levelColor = const Color(0xFFFFB37C);
        break;
      case 5:
        levelColor = const Color(0xFFFF6C00);
        break;
      case 6:
        levelColor = const Color(0xFFFF0000);
        break;
      default:
        levelColor = const Color(0xFFBFBFBF);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: levelColor, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'LV$level',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: levelColor,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
