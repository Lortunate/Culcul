import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_stat_item.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_banner.dart';
import 'package:culcul/features/profile/presentation/widgets/user_profile_buttons.dart';
import 'package:culcul/ui/widgets/app_image_preview.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileInfo extends HookConsumerWidget {
  final ProfileUser? profile;

  static const double _bannerHeight = 160.0;
  static const double _avatarSize = 88.0;
  static const double _borderRadius = 20.0;

  const UserProfileInfo({super.key, required this.profile});

  void _showImagePreview(BuildContext context, String? url) {
    if (url == null || url.isEmpty) return;
    AppImagePreview.open(context, imageUrls: [url], initialIndex: 0);
  }

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
    final authState = ref.watch(authProvider);
    final isSelf =
        authState.isLoggedIn && authState.user?.id.toString() == user.id.toString();

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: _bannerHeight + 20,
              width: double.infinity,
              child: UserProfileBanner(
                bannerUrl: user.bannerUrl,
                onTap: () => _showImagePreview(context, user.bannerUrl),
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
                    _UserIdentity(user: user),
                    if (user.isVerified) const _VerifiedBadge(),
                    const SizedBox(height: 12),
                    _UidTag(uid: user.id),
                    if (user.bio != null && user.bio!.isNotEmpty)
                      _BioSection(
                        bio: user.bio!,
                        isExpanded: isExpanded.value,
                        onToggle: () => isExpanded.value = !isExpanded.value,
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
                  onTap: () => _showImagePreview(context, user.avatarUrl),
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
                      onTap: () =>
                          FollowingsRoute(vmid: int.parse(user.id)).push(context),
                    ),
                    UserProfileStatItem(
                      count: user.followersCount,
                      label: t.profile.stats.followers,
                      onTap: () => FollowersRoute(vmid: int.parse(user.id)).push(context),
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
