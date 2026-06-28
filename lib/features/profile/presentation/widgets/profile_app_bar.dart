import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/state/profile_view_model.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/ui/widgets/users/user_tags.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileAppBar extends ConsumerWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(currentUserProvider);
    final profile = ref.watch(myProfileProvider).value;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isVip = profile?.vipStatus == 1;
    final currentExp = profile?.currentExp;
    final currentMinExp = profile?.currentMinExp;
    final nextExp = profile?.nextExp;
    final expProgress = currentExp != null && currentMinExp != null
        ? nextExp != null && nextExp > currentMinExp
              ? ((currentExp - currentMinExp) / (nextExp - currentMinExp)).clamp(0.0, 1.0)
              : 1.0
        : null;
    final bio = profile?.bio;

    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      stretch: true,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 22),
          onPressed: ProfileNavigationScope.of(context).onOpenSettings,
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: colorScheme.surface,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Hero(
                tag: 'profile_avatar',
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isVip
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      width: 2,
                    ),
                  ),
                  child: AppAvatar(
                    url: profile?.avatarUrl ?? session?.avatarUrl,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            profile?.username ?? session?.nickname ?? '',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isVip ? colorScheme.primary : colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVip) ...[
                          const SizedBox(width: 8),
                          VipTag(type: profile!.vipType, showShadow: true),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (profile != null)
                      Row(
                        children: [
                          LevelTag(level: profile.level),
                          if (expProgress != null) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: colorScheme.surfaceContainerHighest
                                            .withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: expProgress,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                colorScheme.tertiary,
                                                colorScheme.primary,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    nextExp != null
                                        ? '$currentExp/$nextExp'
                                        : '$currentExp',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontSize: 10,
                                      color: colorScheme.outline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    if (bio != null && bio.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        bio,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
