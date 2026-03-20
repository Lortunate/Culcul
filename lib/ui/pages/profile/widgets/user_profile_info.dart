import 'package:culcul/core/router/router.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/providers/auth/auth_provider.dart';
import 'package:culcul/ui/pages/profile/widgets/user_profile_stat_item.dart';
import 'package:culcul/ui/pages/profile/widgets/user_profile_banner.dart';
import 'package:culcul/ui/pages/profile/widgets/user_profile_buttons.dart';
import 'package:culcul/ui/pages/video/widgets/image_preview_page.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileInfo extends HookConsumerWidget {
  final UserProfile? profile;

  const UserProfileInfo({super.key, required this.profile});

  void _showImagePreview(BuildContext context, String url) {
    if (url.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imageUrls: [url],
          initialIndex: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpanded = useState(false);
    final authState = ref.watch(authProvider);

    if (profile == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final isSelf =
        authState.isLoggedIn &&
        authState.user?.id.toString() == profile!.id.toString();

    const double bannerHeight = 160;
    const double avatarSize = 88;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Banner
            SizedBox(
              height: bannerHeight + 20,
              width: double.infinity,
              child: UserProfileBanner(
                bannerUrl: profile!.bannerUrl,
                onTap: () {
                  if (profile!.bannerUrl != null) {
                    _showImagePreview(context, profile!.bannerUrl!);
                  }
                },
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.only(top: bannerHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar Placeholder & Stats
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        children: [
                          // Spacer for Avatar
                          const SizedBox(width: avatarSize + 12),
                          // Stats
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    UserProfileStatItem(
                                      count: profile!.followingCount,
                                      label: '关注',
                                      onTap: () {
                                        FollowingsRoute(
                                          vmid: int.parse(profile!.id),
                                        ).push(context);
                                      },
                                    ),
                                    UserProfileStatItem(
                                      count: profile!.followersCount,
                                      label: '粉丝',
                                      onTap: () {
                                        FollowersRoute(
                                          vmid: int.parse(profile!.id),
                                        ).push(context);
                                      },
                                    ),
                                    UserProfileStatItem(
                                      count: profile!.likesCount,
                                      label: '获赞',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: UserProfileButtons(
                                    profile: profile!,
                                    isSelf: isSelf,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Username & Badges
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            profile!.username,
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
                        if (profile!.vipStatus == 1) ...[
                          VipTag(type: profile!.vipType),
                          const SizedBox(width: 6),
                        ],
                        LevelTag(level: profile!.level),
                      ],
                    ),

                    // Verified Badge
                    if (profile!.isVerified) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            size: 16,
                            color: const Color(0xFFFB7299),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'bilibili认证',
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
                    ],

                    const SizedBox(height: 12),

                    // UID
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'UID: ${profile!.id}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    if (profile!.bio != null && profile!.bio!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => isExpanded.value = !isExpanded.value,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                profile!.bio!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  height: 1.4,
                                ),
                                maxLines: isExpanded.value ? null : 1,
                                overflow: isExpanded.value
                                    ? null
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                            if (profile!.bio!.length > 20)
                              Padding(
                                padding: const EdgeInsets.only(left: 4, top: 2),
                                child: Icon(
                                  isExpanded.value
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  size: 16,
                                  color: colorScheme.outline,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Avatar Overlay
            Positioned(
              top: bannerHeight - (avatarSize * 0.4), // 40% overlapping banner
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: AppAvatar(
                  url: profile!.avatarUrl,
                  size: avatarSize,
                  onTap: () {
                    if (profile!.avatarUrl != null) {
                      _showImagePreview(context, profile!.avatarUrl!);
                    }
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
