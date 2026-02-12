import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/data/models/user/user_profile_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/user_space/user_space_provider.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:culcul/ui/widgets/user_tags.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileInfo extends ConsumerWidget {
  final UserProfile? profile;

  const UserProfileInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    if (profile == null) {
      return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
    }

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Avatar (overlapping) + Stats + Follow Button
          SizedBox(
            height: 60, // Increased height for better overlap handling
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Avatar with transform to overlap
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    padding: const EdgeInsets.all(4), // Thicker border
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: AppAvatar(
                      url: profile!.avatarUrl,
                      size: 80, // Slightly smaller to fit better
                      border: Border.all(
                        color: colorScheme.surfaceContainerHighest,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Stats
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      _buildStatItem(context, profile!.followersCount, '粉丝'),
                      const SizedBox(width: 32), // Increased spacing
                      _buildStatItem(context, profile!.followingCount, '关注'),
                      const SizedBox(width: 32), // Increased spacing
                      _buildStatItem(context, profile!.likesCount, '获赞'),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Row 2: Name + VIP + Level
          Row(
            children: [
              Flexible(
                child: Text(
                  profile!.username,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: profile!.vipStatus == 1
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (profile!.vipStatus == 1) ...[
                const SizedBox(width: 8),
                VipTag(type: profile!.vipType),
              ],
              const SizedBox(width: 8),
              LevelTag(level: profile!.level),
            ],
          ),
          
          // Official Verify
          if (profile!.isVerified) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.verified, size: 16, color: colorScheme.primary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'bilibili认证：${profile!.username}', 
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],

          // Bio
          if (profile!.bio != null && profile!.bio!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              profile!.bio!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          
          // Action Buttons
          const SizedBox(height: 20),
          Row(
            children: [
               Expanded(
                 child: FollowButton(
                  isFollowed: profile!.isFollowing,
                  onTap: () {
                    ref
                        .read(userSpaceProvider(profile!.id).notifier)
                        .toggleFollow();
                  },
                  height: 36,
                             ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: OutlinedButton(
                   onPressed: () {
                      ChatRoute(
                        talkerId: int.parse(profile!.id),
                      ).push(context);
                   },
                   style: OutlinedButton.styleFrom(
                     padding: EdgeInsets.zero,
                     side: BorderSide(color: colorScheme.outlineVariant),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(4),
                     ),
                     minimumSize: const Size.fromHeight(36),
                   ),
                   child: Text(t.profile.actions.message),
                 ),
               ),
               const SizedBox(width: 12),
               SizedBox(
                 width: 36,
                 height: 36,
                 child: IconButton.outlined(
                   onPressed: () {},
                   icon: const Icon(Icons.expand_more, size: 20),
                   style: IconButton.styleFrom(
                     side: BorderSide(color: colorScheme.outlineVariant),
                     padding: EdgeInsets.zero,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(4),
                     ),
                   ),
                 ),
               ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, int count, String label) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          FormatUtils.formatNumber(count),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
