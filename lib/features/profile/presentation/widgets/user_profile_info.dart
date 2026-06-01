import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_buttons.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:culcul/ui/widgets/media/app_image_preview.dart';
import 'package:culcul/ui/assemblies/users/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileHeader extends HookConsumerWidget {
  final ProfileUser? profile;

  static const double _bannerHeight = 160.0;
  static const double _avatarSize = 88.0;
  static const double _borderRadius = 20.0;

  const UserProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = profile;
    if (user == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final isExpanded = useState(false);
    final session = ref.watch(currentUserProvider);
    final isSelf = (session?.isLoggedIn ?? false) && session?.uid == user.id;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: _bannerHeight + 20,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  final bannerUrl = user.bannerUrl;
                  if (bannerUrl == null || bannerUrl.isEmpty) {
                    return;
                  }
                  AppImagePreview.open(context, imageUrls: [bannerUrl]);
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (user.bannerUrl != null && user.bannerUrl!.isNotEmpty)
                      AppNetworkImage(url: user.bannerUrl!)
                    else
                      Container(color: theme.colorScheme.surfaceContainerHighest),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.scrim.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.4],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: _bannerHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(_borderRadius),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatsRow(user: user, isSelf: isSelf, avatarSize: _avatarSize),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.username,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: theme.colorScheme.onSurface,
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
                    ),
                    if (user.isVerified)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                t.profile.verified_badge,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'UID: ${user.id}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (user.bio != null && user.bio!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: GestureDetector(
                          onTap: () => isExpanded.value = !isExpanded.value,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  user.bio!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    height: 1.4,
                                  ),
                                  maxLines: isExpanded.value ? null : 1,
                                  overflow: isExpanded.value
                                      ? null
                                      : TextOverflow.ellipsis,
                                ),
                              ),
                              if (user.bio!.length > 20)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, top: 2),
                                  child: Icon(
                                    isExpanded.value
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    size: 16,
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            Positioned(
              top: _bannerHeight - (_avatarSize * 0.4),
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: AppAvatar(
                  url: user.avatarUrl,
                  size: _avatarSize,
                  onTap: () {
                    final avatarUrl = user.avatarUrl;
                    if (avatarUrl == null || avatarUrl.isEmpty) return;
                    AppImagePreview.open(context, imageUrls: [avatarUrl]);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
                    _ProfileStatItem(
                      count: user.followingCount,
                      label: t.profile.stats.following,
                      onTap: () => navigation.onOpenFollowings(int.parse(user.id)),
                    ),
                    _ProfileStatItem(
                      count: user.followersCount,
                      label: t.profile.stats.followers,
                      onTap: () => navigation.onOpenFollowers(int.parse(user.id)),
                    ),
                    _ProfileStatItem(
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

class _ProfileStatItem extends StatelessWidget {
  final int count;
  final String label;
  final VoidCallback? onTap;

  const _ProfileStatItem({required this.count, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              FormatUtils.formatNumber(count),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
