import 'package:culcul/app/shell/navigation_items.dart';
import 'package:culcul/ui/responsive/app_responsive.dart';
import 'package:culcul/ui/widgets/media/adaptive_blur.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AdaptiveShellScaffold(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: navigationShell.goBranch,
      labels: [t.nav.home, t.nav.moments, t.nav.ranking, t.nav.profile],
      items: NavigationItems.items,
    );
  }
}

class AdaptiveShellScaffold extends StatelessWidget {
  const AdaptiveShellScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.labels,
    required this.items,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<String> labels;
  final List<NavigationItem> items;

  @override
  Widget build(BuildContext context) {
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
                  selectedIndex: currentIndex,
                  onDestinationSelected: onDestinationSelected,
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
                    for (final (index, item) in items.indexed)
                      NavigationRailDestination(
                        icon: Icon(item.icon),
                        selectedIcon: Icon(item.selectedIcon),
                        label: Text(labels[index]),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
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
              currentIndex: currentIndex,
              onTap: onDestinationSelected,
              items: [
                for (final (index, item) in items.indexed)
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
