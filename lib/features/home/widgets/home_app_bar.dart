import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/shared/widgets/app_avatar.dart';
import 'package:cilixili/shared/widgets/app_search_bar.dart';
import 'package:cilixili/shared/widgets/app_tab_bar.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<String> tabs;
  final VoidCallback? onSearchTap;
  final String? hintText;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onGameTap;

  const HomeAppBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.onSearchTap,
    this.hintText,
    this.onAvatarTap,
    this.onMessageTap,
    this.onGameTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      leading: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: AppAvatar(
            url: 'https://picsum.photos/seed/user/100/100',
            size: 30,
            onTap: onAvatarTap,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AppSearchBar(
          onTap: onSearchTap,
          hintText: hintText ?? t.home.search_hint,
        ),
      ),
      actions: [
        _AppBarButton(
          icon: Icons.mail_outline_rounded,
          onPressed: onMessageTap,
        ),
        const SizedBox(width: 6),
      ],
      bottom: AppTabBar(controller: tabController, tabs: tabs),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 42);
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _AppBarButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 22),
      onPressed: onPressed,
      splashRadius: 22,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 38),
    );
  }
}
