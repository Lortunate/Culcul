import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:culcul/core/router/router.dart';

class ProfileActionGrid extends StatelessWidget {
  const ProfileActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _GridItem(
                icon: Icons.cloud_download_outlined,
                label: t.profile.menu.download,
              ),
              _GridItem(
                icon: Icons.history_rounded,
                label: t.profile.menu.history,
                onTap: () => const HistoryRoute().push(context),
              ),
              _GridItem(
                icon: Icons.star_outline_rounded,
                label: t.profile.menu.collection,
                onTap: () => const FavoritesRoute().push(context),
              ),
              _GridItem(
                icon: Icons.play_circle_outline_rounded,
                label: t.profile.menu.later,
                onTap: () => const ToViewRoute().push(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _GridItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: 76,
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
    );
  }
}
