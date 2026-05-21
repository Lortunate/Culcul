import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileStats extends ConsumerWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final profileAsync = ref.watch(myProfileProvider);

    final postsCount = profileAsync.maybeWhen(
      data: (profile) => FormatUtils.formatNumber(profile.dynamicCount),
      orElse: () => '-',
    );
    final followingCount = profileAsync.maybeWhen(
      data: (profile) => FormatUtils.formatNumber(profile.followingCount),
      orElse: () => '-',
    );
    final followersCount = profileAsync.maybeWhen(
      data: (profile) => FormatUtils.formatNumber(profile.followersCount),
      orElse: () => '-',
    );
    final vmid = profileAsync.maybeWhen(
      data: (profile) => int.tryParse(profile.id) ?? 0,
      orElse: () => 0,
    );

    return SliverToBoxAdapter(
      child: ResponsiveContentContainer(
        maxWidth: AppBreakpoints.pageMaxWidth,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(bottom: CulculRadius.radiusXl),
          ),
          padding: EdgeInsets.fromLTRB(
            CulculSpacing.md,
            0,
            CulculSpacing.md,
            context.isDesktopLayout ? CulculSpacing.lg : 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                count: postsCount,
                label: t.profile.stats.posts,
                onTap: () {
                  context.showAppFeedback(
                    t.common.coming_soon(tab: t.profile.stats.posts),
                  );
                },
              ),
              Container(
                height: 14,
                width: 1,
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              _StatItem(
                count: followingCount,
                label: t.profile.stats.following,
                onTap: () {
                  if (vmid != 0) {
                    FollowingsRoute(vmid: vmid).push(context);
                  }
                },
              ),
              Container(
                height: 14,
                width: 1,
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              _StatItem(
                count: followersCount,
                label: t.profile.stats.followers,
                onTap: () {
                  if (vmid != 0) {
                    FollowersRoute(vmid: vmid).push(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  final VoidCallback? onTap;

  const _StatItem({required this.count, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: const BorderRadius.all(CulculRadius.radiusSm),
      child: AppClickable(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CulculSpacing.lg,
            vertical: CulculSpacing.xs,
          ),
          child: Column(
            children: [
              Text(
                count,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
