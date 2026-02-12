import 'package:culcul/core/router/router.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/providers/profile/profile_provider.dart';
import 'package:culcul/ui/widgets/index.dart';
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

    final dynamicCount = profileAsync.maybeWhen(
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
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(
              count: dynamicCount,
              label: t.profile.stats.dynamic,
              onTap: () {
                // TODO: Dynamic page
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

    return AppClickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
    );
  }
}
