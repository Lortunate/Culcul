import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:culcul/ui/responsive/app_breakpoints.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:culcul/app/router/app_routes.dart';

class ProfileActionGrid extends StatelessWidget {
  const ProfileActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final isDesktop = context.isDesktopLayout;
    final actions = _buildActions(context, t, isDesktop);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pageHorizontalPadding),
        child: ResponsiveContentContainer(
          maxWidth: AppBreakpoints.pageMaxWidth,
          horizontalPadding: 0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: isDesktop ? 24 : 20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: isDesktop
                ? _DesktopActionGrid(actions: actions)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (final action in actions.take(4))
                        _GridItem(
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
    );
  }

  List<({IconData icon, String label, VoidCallback? onTap})> _buildActions(
    BuildContext context,
    Translations t,
    bool isDesktop,
  ) {
    final actions = <({IconData icon, String label, VoidCallback? onTap})>[
      (icon: Icons.cloud_download_outlined, label: t.profile.menu.download, onTap: null),
      (
        icon: Icons.history_rounded,
        label: t.profile.menu.history,
        onTap: () => const HistoryRoute().push(context),
      ),
      (
        icon: Icons.star_outline_rounded,
        label: t.profile.menu.favorites,
        onTap: () => const FavoritesRoute().push(context),
      ),
      (
        icon: Icons.play_circle_outline_rounded,
        label: t.profile.menu.watch_later,
        onTap: () => const ToViewRoute().push(context),
      ),
    ];
    if (!isDesktop) {
      return actions;
    }
    return [
      ...actions,
      (
        icon: Icons.palette_outlined,
        label: t.profile.menu.appearance,
        onTap: () => const SettingsRoute().push(context),
      ),
      (
        icon: Icons.support_agent_outlined,
        label: t.profile.menu.support,
        onTap: () =>
            context.showAppFeedback(t.common.coming_soon(tab: t.profile.menu.support)),
      ),
    ];
  }
}

class _DesktopActionGrid extends StatelessWidget {
  const _DesktopActionGrid({required this.actions});

  final List<({IconData icon, String label, VoidCallback? onTap})> actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisSpacing = 16.0;
        final itemWidth = (constraints.maxWidth - crossAxisSpacing * 5) / 6;

        return Wrap(
          spacing: crossAxisSpacing,
          runSpacing: 12,
          children: [
            for (final action in actions)
              _GridItem(
                icon: action.icon,
                label: action.label,
                onTap: action.onTap,
                width: itemWidth,
              ),
          ],
        );
      },
    );
  }
}

class _GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double width;

  const _GridItem({
    required this.icon,
    required this.label,
    this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AppClickable(
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: colorScheme.primary, size: 26),
                const SizedBox(height: 8),
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
