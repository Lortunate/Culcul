import 'package:culcul/ui/theme/culcul_tokens.dart';
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

  BoxDecoration _buildDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surface,
      border: Border(
        bottom: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
    );
  }

  UnderlineTabIndicator _buildIndicator(Color color) {
    return UnderlineTabIndicator(
      borderSide: BorderSide(width: 3, color: color),
      insets: const EdgeInsets.symmetric(horizontal: CulculSpacing.xs),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(CulculRadius.xs)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 44,
      decoration: _buildDecoration(colorScheme),
      child: TabBar(
        controller: controller,
        isScrollable: isScrollable,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: CulculSpacing.xxs),
        tabAlignment: isScrollable ? TabAlignment.start : null,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: _buildIndicator(colorScheme.primary),
        labelPadding: const EdgeInsets.symmetric(horizontal: CulculSpacing.md),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        tabs: tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
