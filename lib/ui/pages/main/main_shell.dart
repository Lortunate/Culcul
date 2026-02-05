import 'dart:ui';

import 'package:culcul/ui/pages/main/widgets/navigation_items.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final labels = [t.nav.home, t.nav.moments, t.nav.ranking, t.nav.mine];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        body: navigationShell,
        extendBody: true,
        bottomNavigationBar: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.75),
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (index) => navigationShell.goBranch(index),
                items: NavigationItems.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Icon(item.icon, size: 24),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Icon(item.selectedIcon, size: 24),
                    ),
                    label: labels[index],
                  );
                }).toList(),
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: colorScheme.primary,
                unselectedItemColor: colorScheme.onSurfaceVariant,
                selectedFontSize: 11,
                unselectedFontSize: 11,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
                enableFeedback: true,
                type: BottomNavigationBarType.fixed,
                landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
