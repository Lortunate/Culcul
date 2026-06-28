import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/widgets/media/adaptive_blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _navigationItems = [
  (icon: Icons.home_outlined, selectedIcon: Icons.home_rounded),
  (icon: Icons.explore_outlined, selectedIcon: Icons.explore_rounded),
  (icon: Icons.leaderboard_outlined, selectedIcon: Icons.leaderboard_rounded),
  (icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded),
];

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final labels = [t.nav.home, t.nav.moments, t.nav.ranking, t.nav.profile];
    assert(labels.length == _navigationItems.length);

    final colorScheme = Theme.of(context).colorScheme;
    const iconPadding = EdgeInsets.only(bottom: 4);

    if (context.isDesktopLayout) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    right: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.25),
                      width: 0.5,
                    ),
                  ),
                ),
                child: NavigationRail(
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: navigationShell.goBranch,
                  backgroundColor: Colors.transparent,
                  extended: context.isExtendedRailLayout,
                  minWidth: 72,
                  minExtendedWidth: 224,
                  groupAlignment: -0.9,
                  labelType: context.isExtendedRailLayout
                      ? null
                      : NavigationRailLabelType.selected,
                  selectedIconTheme: IconThemeData(color: colorScheme.primary, size: 24),
                  unselectedIconTheme: IconThemeData(
                    color: colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                  selectedLabelTextStyle: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelTextStyle: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  destinations: [
                    for (final (index, item) in _navigationItems.indexed)
                      NavigationRailDestination(
                        icon: Icon(item.icon),
                        selectedIcon: Icon(item.selectedIcon),
                        label: Text(labels[index]),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: AdaptiveBlur(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(
                color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: navigationShell.goBranch,
            items: [
              for (final (index, item) in _navigationItems.indexed)
                BottomNavigationBarItem(
                  icon: Padding(padding: iconPadding, child: Icon(item.icon, size: 24)),
                  activeIcon: Padding(
                    padding: iconPadding,
                    child: Icon(item.selectedIcon, size: 24),
                  ),
                  label: labels[index],
                ),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurfaceVariant,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          ),
        ),
      ),
    );
  }
}
