import 'package:cilixili/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;
  final List<String> tabs;
  final bool isScrollable;
  final ValueChanged<int>? onTap;

  const AppTabBar({
    super.key,
    this.controller,
    required this.tabs,
    this.isScrollable = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE3E5E7),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: isScrollable,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        tabAlignment: isScrollable ? TabAlignment.start : null,
        labelColor: AppColors.primary,
        unselectedLabelColor: isDark
            ? AppColors.darkTextSecondary
            : AppColors.textSecondary,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.5, color: AppColors.primary),
          insets: EdgeInsets.symmetric(horizontal: 8),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        tabs: tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(42);
}
