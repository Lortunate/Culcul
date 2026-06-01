import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/format_utils.dart';
import 'package:culcul/features/auth/application/auth_controller.dart';
import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:culcul/features/profile/presentation/widgets/profile_navigation_scope.dart';
import 'package:culcul/features/profile/state/profile_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(currentUserProvider);
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final navigation = ProfileNavigationScope.of(context);
    final isDesktop = context.isDesktopLayout;

    if (!(session?.isLoggedIn ?? false)) {
      return Scaffold(
        body: ResponsiveContentContainer(
          maxWidth: 760,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: navigation.onOpenSettings,
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      t.profile.login_hint,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      onPressed: navigation.onLogin,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(200, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(t.auth.login),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const ProfileAppBar(),
          const _ProfileStats(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.pageHorizontalPadding),
              child: ResponsiveContentContainer(
                maxWidth: AppBreakpoints.pageMaxWidth,
                horizontalPadding: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isDesktop ? CulculSpacing.lg : 20,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.all(CulculRadius.radiusLg),
                  ),
                  child: isDesktop
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            const crossAxisSpacing = 16.0;
                            final itemWidth =
                                (constraints.maxWidth - crossAxisSpacing * 5) / 6;

                            return Wrap(
                              spacing: crossAxisSpacing,
                              runSpacing: 12,
                              children: [
                                for (final action in _profileActions(
                                  context,
                                  t,
                                  navigation,
                                  true,
                                ))
                                  _ProfileActionGridItem(
                                    icon: action.icon,
                                    label: action.label,
                                    onTap: action.onTap,
                                    width: itemWidth,
                                  ),
                              ],
                            );
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (final action in _profileActions(
                              context,
                              t,
                              navigation,
                              false,
                            ))
                              _ProfileActionGridItem(
                                icon: action.icon,
                                label: action.label,
                                onTap: action.onTap,
                                width: 76,
                              ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.pageHorizontalPadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ResponsiveContentContainer(
                  maxWidth: AppBreakpoints.pageMaxWidth,
                  horizontalPadding: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadius.all(CulculRadius.radiusLg),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: AppClickable(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(t.auth.logout),
                            content: Text(t.profile.logout_confirm),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(t.common.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ref.read(authProvider.notifier).logout();
                                },
                                child: Text(
                                  t.auth.logout,
                                  style: TextStyle(color: colorScheme.error),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CulculSpacing.md,
                          vertical: CulculSpacing.md,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: colorScheme.error,
                              size: 24,
                            ),
                            const SizedBox(width: CulculSpacing.md),
                            Expanded(
                              child: Text(
                                t.auth.logout,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.error,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.isDesktopLayout ? 40 : CulculSpacing.xl),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  List<({IconData icon, String label, VoidCallback? onTap})> _profileActions(
    BuildContext context,
    Translations t,
    ProfileNavigationScope navigation,
    bool includeDesktopActions,
  ) {
    return [
      (icon: Icons.cloud_download_outlined, label: t.profile.menu.download, onTap: null),
      (
        icon: Icons.history_rounded,
        label: t.profile.menu.history,
        onTap: navigation.onOpenHistory,
      ),
      (
        icon: Icons.star_outline_rounded,
        label: t.profile.menu.favorites,
        onTap: navigation.onOpenFavorites,
      ),
      (
        icon: Icons.play_circle_outline_rounded,
        label: t.profile.menu.watch_later,
        onTap: navigation.onOpenToView,
      ),
      if (includeDesktopActions) ...[
        (
          icon: Icons.palette_outlined,
          label: t.profile.menu.appearance,
          onTap: navigation.onOpenSettings,
        ),
        (
          icon: Icons.support_agent_outlined,
          label: t.profile.menu.support,
          onTap: () =>
              context.showAppFeedback(t.common.coming_soon(tab: t.profile.menu.support)),
        ),
      ],
    ];
  }
}

class _ProfileActionGridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double width;

  const _ProfileActionGridItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: const BorderRadius.all(CulculRadius.radiusMd),
      child: AppClickable(
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: CulculSpacing.xs),
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: colorScheme.primary, size: 26),
                const SizedBox(height: CulculSpacing.xs),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileStats extends ConsumerWidget {
  const _ProfileStats();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final profileAsync = ref.watch(myProfileProvider);
    final navigation = ProfileNavigationScope.of(context);
    final statDividerColor = colorScheme.outlineVariant.withValues(alpha: 0.5);

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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(bottom: CulculRadius.radiusXl),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              CulculSpacing.md,
              0,
              CulculSpacing.md,
              context.isDesktopLayout ? CulculSpacing.lg : 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ProfileStatItem(
                  count: postsCount,
                  label: t.profile.stats.posts,
                  onTap: () {
                    context.showAppFeedback(
                      t.common.coming_soon(tab: t.profile.stats.posts),
                    );
                  },
                ),
                Container(height: 14, width: 1, color: statDividerColor),
                _ProfileStatItem(
                  count: followingCount,
                  label: t.profile.stats.following,
                  onTap: () {
                    if (vmid != 0) {
                      navigation.onOpenFollowings(vmid);
                    }
                  },
                ),
                Container(height: 14, width: 1, color: statDividerColor),
                _ProfileStatItem(
                  count: followersCount,
                  label: t.profile.stats.followers,
                  onTap: () {
                    if (vmid != 0) {
                      navigation.onOpenFollowers(vmid);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileStatItem extends StatelessWidget {
  final String count;
  final String label;
  final VoidCallback? onTap;

  const _ProfileStatItem({required this.count, required this.label, this.onTap});

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
