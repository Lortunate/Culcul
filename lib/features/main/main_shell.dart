import 'package:cilixili/core/theme/app_colors.dart';
import 'package:cilixili/features/main/navigation_items.dart';
import 'package:cilixili/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainShell extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final t = Translations.of(context);

    final labels = [t.nav.home, t.nav.moments, t.nav.subscription, t.nav.mine];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: isDark
            ? AppColors.darkCardBackground
            : Colors.white,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardBackground : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark
                    ? const Color(0xFF2C2C2E)
                    : const Color(0xFFF1F2F3),
                width: 0.8,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            items: NavigationItems.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Icon(item.icon, size: 22),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Icon(item.selectedIcon, size: 22),
                ),
                label: labels[index],
              );
            }).toList(),
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textSecondary,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          ),
        ),
      ),
    );
  }
}
