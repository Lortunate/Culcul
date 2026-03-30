import 'package:culcul/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_avatar.dart';
import 'package:culcul/ui/widgets/app_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home_tab_bar.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<String> tabs;
  final VoidCallback? onSearchTap;
  final String? hintText;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onGameTap;
  final ValueChanged<int>? onTabTap;

  const HomeAppBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.onSearchTap,
    this.hintText,
    this.onAvatarTap,
    this.onMessageTap,
    this.onGameTap,
    this.onTabTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    final avatarUrl = ref.watch(authProvider.select((state) => state.user?.avatarUrl));

    return AppBar(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 12,
      centerTitle: false,
      leadingWidth: 44,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Center(
          child: AppAvatar(url: avatarUrl, size: 32, onTap: onAvatarTap),
        ),
      ),
      title: AppSearchBar(onTap: onSearchTap, hintText: hintText ?? t.home.search_hint),
      actions: [
        _AppBarButton(icon: Icons.mail_outline_rounded, onPressed: onMessageTap),
        const SizedBox(width: 8),
      ],
      bottom: HomeTabBar(controller: tabController, tabs: tabs, onTap: onTabTap),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 44);
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _AppBarButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 24,
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.9),
      ),
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(40, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
