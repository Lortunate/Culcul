import 'dart:ui';

import 'package:culcul/app/shell/navigation_items.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    final labels = [t.nav.home, t.nav.moments, t.nav.ranking, t.nav.mine];
    const iconPadding = EdgeInsets.only(bottom: 4);

    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
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
                for (final (index, item) in NavigationItems.items.indexed)
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
      ),
    );
  }
}
